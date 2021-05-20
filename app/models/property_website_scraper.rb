class PropertyWebsiteScraper < GenericScraper
  def initialize(url)
    @url = url
    @website_data = {}
  end

  def scrape_data
    document = Nokogiri::HTML.parse(open(@url))
    amenities_url = document.at('a:contains("Amenities")')
    floor_plan_url = document.at('a:contains("Floor Plans")')
    gallery_url = document.at('a:contains("Gallery")')
    contact_us_url = document.at('a:contains("Contact")')
    neighborhood_url = document.at('a:contains("Neighborhood")')
    features_url = document.at('a:contains("Features")')
    facebook_url = document.css("//a[@href*='facebook.com']").first
    instagram_url = document.css("//a[@href*='instagram.com']").first
    @website_data[:amenities_url] = generate_full_url(amenities_url['href']) unless amenities_url.blank?
    @website_data[:floor_plan_url] = generate_full_url(floor_plan_url['href']) unless floor_plan_url.blank?
    @website_data[:gallery_url] = generate_full_url(gallery_url['href']) unless gallery_url.blank?
    @website_data[:contact_us_url] = generate_full_url(contact_us_url['href']) unless contact_us_url.blank?
    @website_data[:neighborhood_url] = generate_full_url(neighborhood_url['href']) unless neighborhood_url.blank?
    @website_data[:features_url] = generate_full_url(features_url['href']) unless features_url.blank?
    @website_data[:facebook_url] = facebook_url['href'] unless facebook_url.blank?
    @website_data[:instagram_url] = instagram_url['href'] unless instagram_url.blank?
    @website_data
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
