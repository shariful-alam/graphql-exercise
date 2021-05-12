module Mutations
  class ScrapeProperty < Mutations::BaseMutation
    argument :propertyName, String, required: true

    field :propertyName, String, null: false
    def resolve(propertyName:)
      {
          propertyName: propertyName
      }
    end
  end
end
