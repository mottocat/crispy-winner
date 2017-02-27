class Product < ApplicationRecord
  # Assciations
  has_many :comments

  # Validations
  validates :name, :brand, presence: true

end
