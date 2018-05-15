class CreateLocations < ActiveRecord::Migration[5.2]
  def change
    create_table :locations do |t|
      t.string :address_1
      t.string :address_2
      # t.string :formatted_address
      # t.string :street_number
      # t.string :street_name_short
      # t.string :street_name_long
      t.string :city, index: true
      # t.string :city_name_short
      # t.string :city_name_long, index: true
      t.string :state
      # t.string :state_name_short
      # t.string :state_name_long, index: true
      # t.string :country_short_name
      t.string :country, index: true#, null: false
      # t.references :country, index: true
      t.string :postal_code
      t.decimal :lat
      t.decimal :lng
      t.string :google_place_id#, index: true
      t.string :source, null: false # Google, SSI, PADI, WRSTC etc.
      t.timestamps
    end
  end
end
