# frozen_string_literal: true

require 'nokogiri'
require 'net/http'
require 'open-uri'

class GenericScraper
  def initialize(search_string)
    @search_string = search_string
  end

  def scrape_data
    url = "https://www.google.com/search?q=#{@search_string}&hl=en&cr=countryUS"
    document = Nokogiri::HTML.parse(open(url))
    property_name = document.xpath("//div[@class='kCrYT']//span//h3[@class='zBAuLc']")
    if property_name.blank?
      url = "https://www.google.com/search?q=#{@search_string} apartments&hl=en&cr=countryUS"
      document = Nokogiri::HTML.parse(open(url))
    end
    property_name = document.xpath("//div[@class='kCrYT']//span//h3[@class='zBAuLc']")
    if property_name.blank?
      apartments_dot_com_url = document.css("//a[@href*='apartments.com']").first
      apartments_dot_com_url = apartments_dot_com_url['href'].split('q=').last.split('&sa=').first
      website_data = ApartmentsDotComScraper.new(apartments_dot_com_url).scrape_data
    else
      website_url = document.xpath("//div[@class='kCrYT']//a[2]").first['href']
      website_url = (website_url.split('.com').first + '.com').split('=').last
      website_data = PropertyWebsiteScraper.new(website_url).scrape_data
      website_data[:property_name] = property_name.text
      website_data[:address] = document.css('.vbShOe.kCrYT span.BNeawe.tAd8D.AP7Wnd').first.text
      website_data[:website_url] = website_url
      website_data[:hours] = document.xpath("//div[2]//div[1]//span[2]//span[1]").text
    end
    property = Property.where('name ilike :search', { search: website_data[:property_name] }).first
    if property.nil?
      initialize_property(website_data)
    else
      update_property(property, website_data)
    end
  end

  private

  def initialize_property(website_data)
    Property.new(
      name: website_data[:property_name],
      website_url: website_data[:website_url],
      hours: { hours: website_data[:hours] },
      address: website_data[:address],
      amenities_url: website_data[:amenities_url],
      floor_plan_url: website_data[:floor_plan_url],
      gallery_url: website_data[:gallery_url],
      contact_us_url: website_data[:contact_us_url],
      neighborhood_url: website_data[:neighborhood_url],
      features_url: website_data[:features_url],
      facebook_url: website_data[:facebook_url],
      instagram_url: website_data[:instagram_url]
    )
  end
  def update_property(property, website_data)
    property.amenities_url = website_data[:amenities_url]
    property.floor_plan_url = website_data[:floor_plan_url]
    property.gallery_url = website_data[:gallery_url]
    property.contact_us_url = website_data[:contact_us_url]
    property.neighborhood_url = website_data[:neighborhood_url]
    property.features_url = website_data[:features_url]
    property.facebook_url = website_data[:facebook_url]
    property.instagram_url = website_data[:instagram_url]
    property
  end
end
