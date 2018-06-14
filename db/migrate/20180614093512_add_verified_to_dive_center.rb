class AddVerifiedToDiveCenter < ActiveRecord::Migration[5.2]
  def change
    add_column :dive_centers, :verified, :integer
  end
end
