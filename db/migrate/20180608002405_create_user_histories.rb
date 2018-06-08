class CreateUserHistories < ActiveRecord::Migration[5.2]
  def change
    create_table :user_histories do |t|
      t.references :user, foreign_key: true
      t.references :dive_center, foreign_key: true

      t.timestamps
    end
  end
end
