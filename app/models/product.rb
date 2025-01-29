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

  # Basic search without custom ordering for performance
  def self.ordered_search(query)
    return none if query.blank?

    search_name(query)
  end

  scope :search, ->(query) { ordered_search(query) }
end
