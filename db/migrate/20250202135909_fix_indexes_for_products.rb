class FixIndexesForProducts < ActiveRecord::Migration[6.0]
  def change
    enable_extension 'pg_trgm'
    enable_extension 'unaccent'

    remove_index :products, name: "products_name_gin"

    execute <<-SQL
      CREATE INDEX products_unaccented_name_gin
      ON products
      USING gin (to_tsvector('simple', unaccented_name));
    SQL

    execute <<-SQL
      CREATE INDEX products_unaccented_name_trgm
      ON products
      USING gin (unaccented_name gin_trgm_ops);
    SQL
  end
end
