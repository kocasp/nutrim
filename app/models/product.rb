class Product < ApplicationRecord
  include PgSearch::Model

  before_save :set_unaccented_name

  def set_unaccented_name
    self.unaccented_name = I18n.transliterate(name).downcase if name_changed?
  end

  pg_search_scope :pg_search,
    against: :unaccented_name,
    using: {
      tsearch: { dictionary: 'simple', prefix: true }
    }

  def self.search(query)
    # Normalize the query for case insensitivity
    normalized_query = query.downcase
    quoted_query = ActiveRecord::Base.connection.quote(normalized_query)

    # Exact match (case-insensitive)
    exact_results = where("unaccented_name ILIKE ?", normalized_query)

    if exact_results.exists? && exact_results.count > 5
      relation = exact_results
    else
      # Starting with the query (case-insensitive)
      starting_results = where("unaccented_name ILIKE ?", "#{normalized_query}%")
      relation = if starting_results.exists?
                  exact_results.or(starting_results)
                else
                  # Partial match (case-insensitive)
                  where("unaccented_name ILIKE ?", "%#{normalized_query}%")
                end
    end

    # Multi-criteria ordering
    relation = relation.order(
      Arel.sql(
        "CASE WHEN unaccented_name ILIKE #{quoted_query} THEN 2 ELSE 0 END DESC, "\
        "CASE WHEN source = 'kalkulator' THEN 1 ELSE 0 END DESC"
      )
    )

    # Fallback to pg_search if no results are found
    relation.count > 0 ? relation : pg_search(query)
  end
end