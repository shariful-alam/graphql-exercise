module Types
  class PropertyType < Types::BaseObject
    field :id, ID, null: false
    field :name, String, null: true
    field :website_url, String, null: true
    field :hours, GraphQL::Types::JSON, null: false
    field :address, String, null: true
    field :amenities_url, String, null: true
    field :floor_plan_url, String, null: true
    field :gallery_url, String, null: true
    field :contact_us_url, String, null: true
    field :neighborhood_url, String, null: true
    field :features_url, String, null: true
    field :facebook_url, String, null: true
    field :instagram_url, String, null: true
    field :text_color, String, null: true
    field :button_background_color, String, null: true
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end
