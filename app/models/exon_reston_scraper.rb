class ExonRestonScraper < GenericScraper

  def initialize(url)
    @url = url
  end

  def get_data
    website_document = Nokogiri::HTML.parse(open(@url))
    amenities_url = @url + website_document.xpath("//a[@class='header__menu-link'][normalize-space()='Amenities']").first['href']
    floor_plan_url = @url + website_document.xpath("//a[@class='header__menu-link'][normalize-space()='Floor Plans']").first['href']
    gallery_url = @url + website_document.xpath("//a[@class='header__menu-link'][normalize-space()='Gallery']").first['href']
    contact_us_url = @url + website_document.xpath("//a[@class='header__menu-link'][normalize-space()='Contact']").first['href']
    neighborhood_url = @url + website_document.xpath("//a[@class='header__menu-link'][normalize-space()='Location']").first['href']
    features_url = @url + website_document.xpath("//a[@class='header__menu-link'][normalize-space()='Residents']").first['href']
    facebook_url = website_document.xpath("//div[@class='header__menu header__menu--extra header__extra']//a[@title='Facebook']").first['href']
    instagram_url = website_document.xpath("//div[@class='header__menu header__menu--extra header__extra']//a[@title='Instagram']").first['href']

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
