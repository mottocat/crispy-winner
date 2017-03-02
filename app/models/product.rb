class Product < ApplicationRecord
  # Assciations
  has_many :comments
  has_many :usage_manifests
  has_many :users, through: :usage_manifests

  # Validations
  validates :name, :brand, presence: true

end
