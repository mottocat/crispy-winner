class Comment < ApplicationRecord
  # Associations
  belongs_to :product
  
  # Validations
  validates :body, :product, presence: true
end
