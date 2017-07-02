class ApprovalImage < ApplicationRecord

  # Associations
  mount_uploader :image, ImageUploader
  belongs_to :user
  belongs_to :product
  has_one :usage_manifest, foreign_key: 'approved_image_id'

  enum status: {
    waiting_approval: 0,
    approved: 1,
    denied: 2
  }

  # Validations
  validates_uniqueness_of :user_id, scope: :product_id

  # Callbacks
  after_save do |approval_image|
    if usage_manifest = UsageManifest.find_by(user: approval_image.user,
                                    product: approval_image.product)
      usage_manifest.approved_image = approval_image.approved? ? approval_image : nil
      usage_manifest.save
    end
  end

end
