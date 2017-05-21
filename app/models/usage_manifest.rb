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

end
