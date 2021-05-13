# frozen_string_literal: true

require 'nokogiri'
require 'net/http'
require 'open-uri'

class PropertyScraper

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
    website_data =
      if website_url == 'https://www.livecarraway.com'
        carraway_data(website_url)
      elsif website_url == 'https://exoreston.com'
        exo_reston_data(website_url)
      else
        raise "Not implemented yet!!" and return
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
  rescue Exception => error
    error
  end

  private

  def exo_reston_data(website_url)
    website_document = Nokogiri::HTML.parse(open(website_url))
    amenities_url = website_url + website_document.xpath("//a[@class='header__menu-link'][normalize-space()='Amenities']").first['href']
    floor_plan_url = website_url + website_document.xpath("//a[@class='header__menu-link'][normalize-space()='Floor Plans']").first['href']
    gallery_url = website_url + website_document.xpath("//a[@class='header__menu-link'][normalize-space()='Gallery']").first['href']
    contact_us_url = website_url + website_document.xpath("//a[@class='header__menu-link'][normalize-space()='Contact']").first['href']
    neighborhood_url = website_url + website_document.xpath("//a[@class='header__menu-link'][normalize-space()='Location']").first['href']
    features_url = website_url + website_document.xpath("//a[@class='header__menu-link'][normalize-space()='Residents']").first['href']
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

  def carraway_data(website_url)
    website_document = Nokogiri::HTML.parse(open(website_url))
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
