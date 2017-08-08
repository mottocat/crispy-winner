class Category < ApplicationRecord
  # Associations
  has_many :products, dependent: :nullify
  
  # Validations
  validates_presence_of :name
end
