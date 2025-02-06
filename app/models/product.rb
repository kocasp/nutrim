class Product < ApplicationRecord
  include PgSearch::Model

  before_save :set_unaccented_name

  def set_unaccented_name
    self.unaccented_name = I18n.transliterate(name) if name_changed?
  end

  pg_search_scope :search,
    against: :unaccented_name,
    using: {
      tsearch: { dictionary: 'simple', prefix: true }
    }

end
