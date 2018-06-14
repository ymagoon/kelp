class UpdateDiveCenterFieldsToBoolean < ActiveRecord::Migration[5.2]
  def change
    change_column :dive_centers, :rent_equipment, :boolean
    change_column :dive_centers, :nitrox, :boolean
    change_column :dive_centers, :rent_computer, :boolean
    change_column :dive_centers, :lodging, :boolean
    change_column :dive_centers, :restaurant, :boolean
    change_column :dive_centers, :bar, :boolean
    change_column :dive_centers, :transfers, :boolean
    change_column :dive_centers, :pool, :boolean
  end
end
