class AddFieldsToDiveCenter < ActiveRecord::Migration[5.2]
  def change
    # enable_extension "hstore"
    # add_column :dive_centers, :languages, :hstore
    # add_index :dive_centers, :languages, using: :gin

    add_column :dive_centers, :hours_of_operation, :string
    add_column :dive_centers, :rent_equipment, :boolean
    add_column :dive_centers, :rent_camera, :boolean
    add_column :dive_centers, :nitrox, :boolean
    add_column :dive_centers, :rent_computer, :boolean
    add_column :dive_centers, :lodging, :boolean
    add_column :dive_centers, :restaurant, :boolean
    add_column :dive_centers, :bar, :boolean
    add_column :dive_centers, :transfers, :boolean
    add_column :dive_centers, :pool, :boolean
  end
end
