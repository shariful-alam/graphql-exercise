class PropertyWebsiteScraper < GenericScraper
  def initialize(url)
    @url = url
    @website_date = {}
  end

  def scrape_data
    website_document = Nokogiri::HTML.parse(open(@url))
    features_url = @url + (website_document.at('a:contains("Features")'))
    @website_date[:feasutes_url] = features_url.strip unless features_url.blank?
    @website_date
  end
end
