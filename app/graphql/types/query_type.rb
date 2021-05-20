module Types
  class QueryType < Types::BaseObject
    # /properties
    field :properties, [Types::PropertyType], null: false do
      argument :propertyName, String, required: true
      argument :startDate, String, required: true
      argument :endDate, String, required: true
      argument :limit, Integer, required: true
      argument :offset, Integer, required: true
    end

    def properties(propertyName:, startDate:, endDate:, limit:, offset:)
      start_date = Date.parse(startDate)
      end_date = Date.parse(endDate)
      Property.where(name: propertyName,
                     updated_at: start_date.beginning_of_day..end_date.end_of_day).limit(limit).offset(offset)
    end
  end
end
