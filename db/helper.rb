EMAIL_EXPRESSION = /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
URL_EXPRESSION = /(https?:\/\/(?:www\.|(?!www))[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]\.[^\s]{2,}|www\.[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]\.[^\s]{2,}|https?:\/\/(?:www\.|(?!www))[a-zA-Z0-9]\.[^\s]{2,}|www\.[a-zA-Z0-9]\.[^\s]{2,})/

def clean(string)
  string.nil? ? "" : string.gsub(/[\n\\\"\r]/,'')
end

def extract_number(type, uncleaned_phones)
  search_pattern = Regexp.new(type)
  # Set to -999 so uncleaned_phones[-999] always returns nil and loop never runs. uncleaned_phones[nil] throws error
  pos = uncleaned_phones =~ search_pattern ? (uncleaned_phones =~ search_pattern) + type.length : -999
  number = []

  while uncleaned_phones[pos] =~ /[\+0-9]/
    number << uncleaned_phones[pos]
    pos += 1
  end

  # Removes two + in a row in the event a phone number is formatted like this
  number[0..1].join == "++" ? number[1..-1].join : number.join
end

def find_address(lat, lng)
  base_url = 'https://maps.googleapis.com/maps/api/geocode/json?latlng='
  url = "#{base_url}#{lat},#{lng}&key=#{ENV["google_geocode_key"]}"

  parsed_json = JSON.parse(RestClient.get(url))
  parsed_json
end

def parse_google_geocode(address_json)
  if address_json['status'] == "OK"
    loc_attributes[:google_place_id] = address_json['results'][0]['place_id']

    address_json['results'][0]['address_components'].each do |component|
      if component['types'].include?('street_number')
        street_num = component['short_name'] || ''
        street_num.strip!
        loc_attributes[:address_1] = street_num unless street_num == 'Unnamed Road'
        loc_attributes[:address_1] = '' if loc_attributes[:address_1] = 'Unnamed Road'
      elsif component['types'].include?('route')
        if loc_attributes[:address_1].nil?
          loc_attributes[:address_1] = "#{component['long_name']}"
        else
          loc_attributes[:address_1] = "#{loc_attributes[:address_1]} #{component['long_name']}"
        end
      elsif component['types'].include?('locality')
        loc_attributes[:city] = component['long_name']
      elsif component['types'].include?('administrative_area_level_1')
        loc_attributes[:state] = component['long_name']
      elsif component['types'].include?('country')
        loc_attributes[:country] = component['long_name']
      elsif component['types'].include?('postal_code')
        loc_attributes[:postal_code] = component['short_name']
      end
    end
  else
    puts 'Could not find address'
  end

  loc_attributes
end
