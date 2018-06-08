class CreateUserSearches < ActiveRecord::Migration[5.2]
  def change
    create_table :user_searches do |t|
      t.references :user, foreign_key: true
      t.string :search_string, null: false

      t.timestamps
    end
  end
end
