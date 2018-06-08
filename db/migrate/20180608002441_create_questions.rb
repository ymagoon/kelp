class CreateQuestions < ActiveRecord::Migration[5.2]
  def change
    create_table :questions do |t|
      t.string :question, null: false
      t.references :user, foreign_key: true
      t.references :dive_center, foreign_key: true

      t.timestamps
    end
  end
end
