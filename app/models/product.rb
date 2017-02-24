class Product < ApplicationRecord

  validates :name, :brand, presence: true

end
