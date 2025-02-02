class Product < ApplicationRecord
  include PgSearch::Model

  before_save :set_unaccented_name

  def set_unaccented_name
    self.unaccented_name = I18n.transliterate(name) if name_changed?
  end

  pg_search_scope :search_name,
    against: :unaccented_name,
    using: {
      tsearch: { dictionary: 'simple', prefix: true }
    }

  scope :fast_search, ->(query) {
    where("unaccented_name ILIKE ?", "%#{query}%") if query.present?
  }

  def self.ordered_search(query)
    return none if query.blank?
    
    search_name(query)
  end

  scope :search, ->(query) { ordered_search(query) }
end
