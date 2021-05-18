# frozen_string_literal: true

require 'nokogiri'
require 'net/http'
require 'open-uri'

class GenericScraper
  def initialize(search_string)
    @search_string = search_string
  end

  def scrape_data
    url = "https://www.google.com/search?q=#{@search_string}&hl=en"
    document = Nokogiri::HTML.parse(open(url))
    property_name = document.xpath("//div[@class='kCrYT']//span//h3[@class='zBAuLc']").text
    property_address = document.css('.vbShOe.kCrYT span.BNeawe.tAd8D.AP7Wnd').first.text
    website_url = document.xpath("//div[@class='kCrYT']//a[2]").first['href']
    website_url = (website_url.split('.com').first + '.com').split('=').last
    hours = document.xpath("//div[2]//div[1]//span[2]//span[1]").text
    property = Property.where('name ilike :search', { search: property_name }).first
    if property.nil?
      website_data =
        if website_url == 'https://www.livecarraway.com'
          CarrawayScraper.new(website_url).scrape_data
        elsif website_url == 'https://exoreston.com'
          ExonRestonScraper.new(website_url).scrape_data
        else
          {}
        end
      Property.new(
          name: property_name,
          website_url: website_url,
          hours: { hours: hours },
          address: property_address,
          amenities_url: website_data[:amenities_url],
          floor_plan_url: website_data[:floor_plan_url],
          gallery_url: website_data[:gallery_url],
          contact_us_url: website_data[:contact_us_url],
          neighborhood_url: website_data[:neighborhood_url],
          features_url: website_data[:features_url],
          facebook_url: website_data[:facebook_url],
          instagram_url: website_data[:instagram_url]
      )
    else
      property
    end
  end
end
