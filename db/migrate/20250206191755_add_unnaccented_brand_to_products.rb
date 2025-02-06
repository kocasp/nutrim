class AddUnnaccentedBrandToProducts < ActiveRecord::Migration[8.0]
  def change
    add_column :products, :unaccented_brand, :string
  end
end
