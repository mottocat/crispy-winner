class UsageManifest < ApplicationRecord

  enum status: [:used, :using]

  # Associations
  belongs_to :user
  belongs_to :product

  # Validations
  validates :user, :product, :status, presence: true

  # Scopes
  scope :with_status, ->(status) { where(status: status) }
end
