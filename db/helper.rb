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
  url = "#{base_url}#{lat},#{lng}&key=#{api_key}"

  parsed_json = JSON.parse(RestClient.get(url))
  parsed_json
end
