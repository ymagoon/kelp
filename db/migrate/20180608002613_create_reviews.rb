class CreateReviews < ActiveRecord::Migration[5.2]
  def change
    create_table :reviews do |t|
      t.string :feedback
      t.integer :staff, null: false
      t.integer :boat, null: false
      t.integer :safety, null: false
      t.integer :facilities, null: false
      t.integer :rental_equipment, null: false
      t.integer :eco_friendly, null: false
      t.integer :logistics, null: false
      t.float :overall
      t.references :dive_center
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
