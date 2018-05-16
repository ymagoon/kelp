require 'pry'

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
  response = []

  parsed_json = JSON.parse(RestClient.get(url))
  response[0] = parsed_json
  response[1] = parsed_json['status']

  response
end

def parse_google_geocode(address_json)
  loc_attributes = {}
  status = 'OK'

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

  loc_attributes
end

def set_dive_center_type(value)
  case value.upcase
  when "DC"
    dive_center_type = 'Dive Center'
  when "DDC"
    dive_center_type = 'Diamond Dive Center'
  when "DR"
    dive_center_type = 'Dive Resort'
  when "DS"
    dive_center_type = 'Dive School'
  when "ITC"
    dive_center_type = 'Instructor Training Center'
  when "DITC"
    dive_center_type = 'Diamond Instructor Training Center'
  when "OTPC"
    dive_center_type = 'Online Training Partner Center'
  when "DTPC"
    dive_center_type = 'Dive Trophy Partner Center'
  when "SRC"
    dive_center_type = 'Scuba Rangers Club'
  when "SNO"
    dive_center_type = 'Snorkel Club'
  when "FRD"
    dive_center_type = 'Freediving Center'
  when "TXR"
    dive_center_type = 'Technical Extended Range Center'
  when "MDB"
    dive_center_type = 'Ocean Ranger Station (Mission Deep Blue)'
  when "SSI"
    dive_center_type = 'SSI Service Center'
  else
    dive_center_type = ''
  end

  dive_center_type
end

def open_parse_json(file_path)
  dir = File.dirname(__FILE__)
  raw_json = File.open(File.join(dir, file_path)).read
  parsed_json = JSON.parse(raw_json)

  parsed_json
end
