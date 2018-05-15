class CreateLoadDiveCenters < ActiveRecord::Migration[5.2]
  def change
    create_table :load_dive_centers do |t|
      t.integer :store_number, null: false, index: true
      t.decimal "lat"
      t.decimal "lng"
      t.integer "active_ind", default: 1
      t.string "dive_center_type"

      t.timestamps
    end
  end
end
