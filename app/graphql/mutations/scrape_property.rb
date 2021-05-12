module Mutations
  class ScrapeProperty < Mutations::BaseMutation
    argument :property_name, String, required: true

    type Types::PropertyType

    def resolve(property_name:)
      Property.create(name: property_name)
    end
  end
end
