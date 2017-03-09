# It is a service class.
# Why:
# - To get product, comment, image. state from a single form
# - For easily moderation
class ProductUsage < ApplicationRecord
  mount_uploaders :images, ImageUploader
  enum usage_status: UsageManifest.statuses.keys

  # Associatons
  belongs_to :user

  # Validations
  validates :user, :product_name, :usage_status, :comment_body, :images, presence: true
end
