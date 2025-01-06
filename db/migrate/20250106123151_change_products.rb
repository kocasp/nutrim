class ChangeProducts < ActiveRecord::Migration[8.0]
  def change
    remove_column :products, :url_id, :integer
    add_column :products, :source, :string
    add_column :products, :brand, :string
  end
end
