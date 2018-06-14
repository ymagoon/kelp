class AddDefaultValueToDiveCenters < ActiveRecord::Migration[5.2]
  def change
    change_column :dive_centers, :rent_equipment, :boolean, default: false
    change_column :dive_centers, :nitrox, :boolean, default: false
    change_column :dive_centers, :rent_computer, :boolean, default: false
    change_column :dive_centers, :lodging, :boolean, default: false
    change_column :dive_centers, :restaurant, :boolean, default: false
    change_column :dive_centers, :bar, :boolean, default: false
    change_column :dive_centers, :transfers, :boolean, default: false
    change_column :dive_centers, :pool, :boolean, default: false
  end
end
