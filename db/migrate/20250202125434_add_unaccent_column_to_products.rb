class AddUnaccentColumnToProducts < ActiveRecord::Migration[8.0]
  def change
    add_column :products, :unaccented_name, :text
    remove_index :products, name: "products_name_gin"
    add_index :products, "to_tsvector('simple', unaccented_name)", using: :gin, name: "products_name_gin"
  end
end
