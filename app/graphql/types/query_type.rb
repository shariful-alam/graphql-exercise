module Types
  class QueryType < Types::BaseObject
    # /properties
    field :properties, [Types::PropertyType], null: false do
      argument :propertyName, String, required: true
      argument :startDate, String, required: true
      argument :endDate, String, required: true
    end

    def properties(propertyName:, startDate:, endDate:)
      start_date = Date.parse(startDate)
      end_date = Date.parse(endDate)
      Property.where('name ilike :name AND updated_at >= :start_date AND updated_at <= :end_date', {name: propertyName, start_date: start_date, end_date: end_date})
    end
  end
end
