class UsageManifest < ApplicationRecord

  enum status: [:used, :using]

  # Associations
  belongs_to :user
  belongs_to :product
  belongs_to :approved_image, class_name: "ApprovalImage",
                                  required: false, dependent: :destroy

  # Callbacks
  after_destroy do |usage_manifest|
    ApprovalImage.find_by(user: user, product: product).try(:destroy)
  end

  after_save :update_product_using_or_used_users_count
  after_destroy :update_product_using_or_used_users_count


  # Validations
  validates :user, :product, :status, presence: true

  # Scopes
  scope :with_status, ->(status) { where(status: status) }

  def need_approval?
    using? && !approved_image
  end

  def waiting_for_approval?
    ApprovalImage.find_by(user: user, product: product, status: :waiting_approval)
  end

  private

  def update_product_using_or_used_users_count
    product.used_users_count  = product.usage_manifests.with_status(:used).count
    product.using_users_count = product.usage_manifests.with_status(:using).where.not(approved_image_id: nil).count
    product.save(validate: false)
  end

end
