class Product < ApplicationRecord
  # Assciations
  has_many :comments, dependent: :destroy
  has_many :usage_manifests, dependent: :destroy
  has_many :users, through: :usage_manifests

  # Validations
  validates :name, :brand, presence: true

  # Dependencies
  include PgSearch
  pg_search_scope :search, against: { name: 'A', brand: 'B' }

  def display
    "#{brand} #{name}"
  end

end
