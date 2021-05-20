class PropertyWebsiteScraper < GenericScraper
  def initialize(url)
    @url = url
    @website_date = {}
  end

  def scrape_data
    puts "website url:"
    puts @url
    website_document = Nokogiri::HTML.parse(open(@url))
    amenities_url = website_document.at('a:contains("Amenities")')
    floor_plan_url = website_document.at('a:contains("Floor Plans")')
    gallery_url = website_document.at('a:contains("Gallery")')
    contact_us_url = website_document.at('a:contains("Contact")')
    neighborhood_url = website_document.at('a:contains("Neighborhood")')
    features_url = website_document.at('a:contains("Features")')
    facebook_url = website_document.css("//a[@href*='facebook.com']").first
    instagram_url = website_document.css("//a[@href*='instagram.com']").first
    @website_date[:amenities_url] = generate_full_url(amenities_url['href']) unless amenities_url.blank?
    @website_date[:floor_plan_url] = generate_full_url(floor_plan_url['href']) unless floor_plan_url.blank?
    @website_date[:gallery_url] = generate_full_url(gallery_url['href']) unless gallery_url.blank?
    @website_date[:contact_us_url] = generate_full_url(contact_us_url['href']) unless contact_us_url.blank?
    @website_date[:neighborhood_url] = generate_full_url(neighborhood_url['href']) unless neighborhood_url.blank?
    @website_date[:features_url] = generate_full_url(features_url['href']) unless features_url.blank?
    @website_date[:facebook_url] = facebook_url['href'] unless facebook_url.blank?
    @website_date[:instagram_url] = instagram_url['href'] unless instagram_url.blank?

    @website_date

  end
  private
  def generate_full_url(specific_url)
    if specific_url.include?(@url)
      specific_url
    else
      @url + specific_url
    end
  end
end
