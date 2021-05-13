module Mutations
  class ScrapeProperty < Mutations::BaseMutation
    argument :property_name, String, required: true

    type Types::PropertyType

    def resolve(property_name:)
      property = PropertyScraper.new(property_name).scrape_data
      if property.kind_of?(Property)
        if property.save
          {
              property: property,
              errors: []
          }
        else
          {
              property: nil,
              errors: property.errors.full_messages
          }
        end
      else
        raise "Bad request!!"
      end
    end
  end
end
