class CreateProducts < ActiveRecord::Migration[8.0]
  def change
    create_table :products do |t|
      t.integer :url_id
      t.string :name
      t.string :kcal
      t.string :protein
      t.string :carbs
      t.string :fat
      t.string :fiber

      t.timestamps
    end
  end
end
