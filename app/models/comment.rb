class Comment < ApplicationRecord
  # Associations
  belongs_to :product
  belongs_to :author, class_name: "User", foreign_key: 'author_id'
  
  # Validations
  validates :body, :product, presence: true
end
