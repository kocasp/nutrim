class Product < ApplicationRecord
    scope :search, ->(query) {
        return all unless query.present?
        where('name ILIKE :query', query: "%#{query}%")
      }
end
