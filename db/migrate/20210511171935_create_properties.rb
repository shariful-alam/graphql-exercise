class CreateProperties < ActiveRecord::Migration
  def change
    create_table :properties do |t|
      t.string  :name
      t.string  :website_url
      t.jsonb   :hours, null: false, default: {}
      t.string  :address
      t.string  :amenities_url
      t.string  :floor_plan_url
      t.string  :gallery_url
      t.string  :contact_us_url
      t.string  :neighborhood_url
      t.string  :features_url
      t.string  :facebook_url
      t.string  :instagram_url
      t.string  :text_color
      t.string  :button_background_color

      t.timestamps null: false
    end
  end
end
