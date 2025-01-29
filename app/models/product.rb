class Product < ApplicationRecord
  include PgSearch::Model

  pg_search_scope :search_name,
    against: :name,
    using: {
      tsearch: {
        dictionary: 'simple',
        prefix: true
      },
      trigram: {
        threshold: 0.3 # Adjust threshold for similarity matching
      }
    },
    ignoring: :accents

  # Enhanced search with ordering
  def self.ordered_search(query)
    return none if query.blank?

    safe_query = ActiveRecord::Base.connection.quote_string(query.to_s.strip)

    search_name(query)
      .select(<<-SQL.squish)
        products.*,
        CASE
          WHEN unaccent(products.name) ILIKE unaccent('#{safe_query}') THEN 1
          WHEN unaccent(products.name) ILIKE unaccent('#{safe_query}%') THEN 2
          ELSE similarity(unaccent(products.name), unaccent('#{safe_query}'))
        END AS custom_order
      SQL
      .order(Arel.sql("custom_order DESC, similarity(unaccent(products.name), unaccent('#{safe_query}')) DESC"))
  end

  scope :search, ->(query) { ordered_search(query) }
end
