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

    start_time = Time.now
    result = search_name(query)
    end_time = Time.now

    puts "SEARCH_QUERY: '#{query}' executed in #{(end_time - start_time).round(5)} seconds"
    
    result
  end

  scope :search, ->(query) { ordered_search(query) }
end
