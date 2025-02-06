class AddIndexToProductsUnaccentedBrand < ActiveRecord::Migration[8.0]
  def change
    add_index :products, :unaccented_brand
  end
end
