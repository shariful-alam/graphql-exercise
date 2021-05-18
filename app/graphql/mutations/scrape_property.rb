module Mutations
  class ScrapeProperty < Mutations::BaseMutation
    argument :property_name, String, required: true
    field :property, Types::PropertyType, null: false
    field :errors, [String], null: false
    def resolve(property_name:)
      property = GenericScraper.new(property_name).scrape_data
      if property.kind_of?(Property)
        if property.persisted?
          {
            property: property,
            errors: []
          }
        elsif property.save
          {
            property: property,
            errors: []
          }
        else
          {
            property: Property.new,
            errors: property.errors.full_messages.join(",")
          }
        end
      else
        raise 'Bad request!!'
      end
    end
  end
end
