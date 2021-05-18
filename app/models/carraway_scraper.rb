class CarrawayScraper < GenericScraper
  
  def initialize(url)
    @url = url
  end

  def scrape_data
    website_document = Nokogiri::HTML.parse(open(@url))
    amenities_url = website_document.xpath("//a[normalize-space()='Amenities']").first['href']
    floor_plan_url = website_document.xpath("//li[@id='menu-item-1760']//a[normalize-space()='Floor Plans']").first['href']
    gallery_url = website_document.xpath("//a[normalize-space()='Gallery']").first['href']
    contact_us_url = website_document.xpath("//li[@id='menu-item-800']//a[normalize-space()='Contact']").first['href']
    neighborhood_url = website_document.xpath("//a[normalize-space()='Neighborhood']").first['href']
    features_url = website_document.xpath("//a[normalize-space()='Features']").first['href']
    facebook_url = website_document.xpath("//div[@class='secondary nav-text']//a[@aria-label='Www.facebook']").first['href']
    instagram_url = website_document.xpath("//div[@class='secondary nav-text']//a[@aria-label='Www.instagram']").first['href']

    {
      amenities_url: amenities_url,
      floor_plan_url: floor_plan_url,
      gallery_url: gallery_url,
      contact_us_url: contact_us_url,
      neighborhood_url: neighborhood_url,
      features_url: features_url,
      facebook_url: facebook_url,
      instagram_url: instagram_url
    }
  end
end
