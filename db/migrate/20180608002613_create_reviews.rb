class CreateReviews < ActiveRecord::Migration[5.2]
  def change
    create_table :reviews do |t|
      t.string :feedback
      t.integer :staff
      t.integer :boat
      t.integer :safety
      t.integer :facilities
      t.integer :rental_equipment
      t.integer :eco_friendly
      t.integer :logistics
      t.float :overall
      t.referenecs :dive_center
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
