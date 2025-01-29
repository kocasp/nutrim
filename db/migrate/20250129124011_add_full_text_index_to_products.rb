class AddFullTextIndexToProducts < ActiveRecord::Migration[6.0]
  def change
    execute "CREATE INDEX products_name_gin ON products USING gin(to_tsvector('simple', name))"
  end
end
