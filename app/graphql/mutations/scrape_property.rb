module Mutations
  class ScrapeProperty < Mutations::BaseMutation
    argument :property_name, String, required: true
    field :property, Types::PropertyType, null: false
    def resolve(property_name:)
      property = GenericScraper.new(property_name).scrape_data
      if property.kind_of?(Property)
        if property.save
          {
            property: property
          }
        else
          Rails.logger.error property.errors.full_messages.join(",")
          GraphQL::ExecutionError.new('Could not find property with the given name!!')
        end
      else
        GraphQL::ExecutionError.new(property)
      end
    end
  end
end
