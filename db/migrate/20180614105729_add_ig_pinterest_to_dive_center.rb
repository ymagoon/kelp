class AddIgPinterestToDiveCenter < ActiveRecord::Migration[5.2]
  def change
    add_column :dive_centers, :ig, :string
    add_column :dive_centers, :pinterest, :string
  end
end
