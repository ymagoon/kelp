class CreateDcCourses < ActiveRecord::Migration[5.2]
  def change
    create_table :dc_courses do |t|
      t.integer :price
      t.string :currency
      t.references :course, foreign_key: true
      t.references :dive_center, foreign_key: true

      t.timestamps
    end
  end
end
