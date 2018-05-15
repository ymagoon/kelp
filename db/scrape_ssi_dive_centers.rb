# This scrape was very messy due to a horribly formatted SSI website. I'll try to explain
# what I'm doing the best I can.
def scrape_ssi_dive_centers(store_number)
  url = "https://my.divessi.com/show/#{store_number}"

  puts 'getting data...'
  data = Nokogiri::HTML(RestClient.get(url))
  puts 'got data..'

  name = data.search('.well h3[align="center"]').text

  dc_data = data.search('.col-xs-12')[0].text.gsub(/\t/,'').split(/\n/).select { |data| !data.empty? }

  # There is no easy way to extract all URL information cleanly, so the only solution I
  # could come up with is to pull ALL URL's at once. This includes website, fb, twitter,
  # youtube, etc links
  urls = dc_data.grep(URL_EXPRESSION) { |url| url.match(URL_EXPRESSION)[0] }

  # With urls (array), we can now search through it for fb, twitter and youtube links
  fb = urls.find { |url| url.downcase =~ /facebook/ } || ""
  urls.delete_at(urls.index(fb)) unless fb.empty?

  twitter = urls.find { |url| url.downcase =~ /twitter/ } || ""
  urls.delete_at(urls.index(twitter)) unless twitter.empty?

  youtube = urls.find { |url| url.downcase =~ /youtu/ } || ""
  urls.delete_at(urls.index(youtube)) unless youtube.empty?

  website = urls[0] # Should be the last and only url left

  email = dc_data.select { |email| email =~ EMAIL_EXPRESSION }[0] # take first email

  # Phone numbers were very difficult based on the formatting of the phone number itself, but
  # also because of how they were presented on the website. Grep is finding the POSITION of
  # either Phone Fax or Mobile and applying the block to it to clean it by removing all spaces
  # and weird characters.
  uncleaned_phones = dc_data.grep(/(Phone|Fax|Mobile)/) { |phone| phone.gsub(/[\s\.\(\)]/,'') }[0]

  # Calling extract_number will actually pull the number from the text
  if uncleaned_phones
    phone = extract_number('Phone:', uncleaned_phones)
    mobile = extract_number('Mobile',uncleaned_phones)
    fax = extract_number('Fax', uncleaned_phones)
  else
    phone = ''
    mobile = ''
    fax = ''
  end

  dc_hash = { name: name, primary_phone: phone, mobile_phone: mobile, website: website,
              email: email, fax: fax, fb: fb, twitter: twitter, youtube: youtube }

  dc_hash
end
