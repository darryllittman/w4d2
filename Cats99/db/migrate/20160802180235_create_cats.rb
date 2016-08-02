class CreateCats < ActiveRecord::Migration
  def change
    create_table :cats do |t|
      t.date :birth_date, null: false
      t.text :color, null: false
      t.text :name, null: false
      t.string :sex, null: false, limit: 1
      t.text :description, null: false
      t.timestamps null: false
    end
  end
end
