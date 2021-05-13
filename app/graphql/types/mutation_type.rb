module Types
  class MutationType < Types::BaseObject
    field :scrape_property, mutation: Mutations::ScrapeProperty
  end
end
