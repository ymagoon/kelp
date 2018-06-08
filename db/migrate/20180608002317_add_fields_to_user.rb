class AddFieldsToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :full_name, :string
    add_column :users, :username, :string
    add_column :users, :phone, :string
    add_reference :users, :location, foreign_key: true
  end
end
