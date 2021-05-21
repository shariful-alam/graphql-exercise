# frozen_string_literal: true

class ApartmentsDotComScraper < GenericScraper
  def initialize(url)
    @url = url
    @user_agent = 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_7_0) AppleWebKit/535.2 (KHTML, like Gecko) Chrome/15.0.854.0 Safari/535.2'
  end

  def scrape_data
    document = Nokogiri::HTML.parse(open(@url, 'User-Agent' => @user_agent))
    website_url = document.xpath("//a[@title='View Property Website']").first
    website_data = {}
    if website_url.blank?
      website_data[:amenities_url] = "#{@url}##{document.xpath("//button[normalize-space()='Amenities']").first['data-sectionid']}"
      website_data[:floor_plan_url] = "#{@url}##{document.xpath("//button[normalize-space()='Pricing']").first['data-sectionid']}"
      website_data[:contact_us_url] = "#{@url}##{document.xpath("//button[normalize-space()='Contact']").first['data-sectionid']}"
    else
      website_data = PropertyWebsiteScraper.new(website_url['href']).scrape_data
      website_data[:website_url] = website_url['href']
    end
    website_data[:property_name] = document.css('#propertyName').text.strip
    hours_hash = {}
    hours = document.xpath("//ul[@class='officeHoursContainer']").search('li')
    hours.each do |hour|
      hour_text = hour.text.split(',')
      day = hour_text.first.strip
      time = hour_text.last.strip
      hours_hash[day] = time
    end
    website_data[:hours] = hours_hash
    address = "#{document.xpath("//body/div[@class='mainWrapper']/main/section[@id='profileApp']/div[@id='profileWrapper']/div[@id='profilePaid']/div[@class='profileContent']/header[@id='profileHeaderWrapper']/div[@id='propertyHeader']/div[@class='column columnOne']/div[@id='propertyAddressRow']/div[@class='propertyAddressContainer']/h2[1]/span[1]").text}, "
    address = "#{address}#{document.xpath("//body/div[@class='mainWrapper']/main/section[@id='profileApp']/div[@id='profileWrapper']/div[@id='profilePaid']/div[@class='profileContent']/header[@id='profileHeaderWrapper']/div[@id='propertyHeader']/div[@class='column columnOne']/div[@id='propertyAddressRow']/div[@class='propertyAddressContainer']/h2[1]/span[2]").text}, "
    address += document.xpath("//span[@class='stateZipContainer']").text.split(' ').join(' ')
    website_data[:address] = address
    website_data
  end
end
