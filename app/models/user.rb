class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Associatons
  has_many :usage_manifests
  has_many :products, through: :usage_manifests

  def usage_manifest_for product
    usage_manifests.find_by(product: product)
  end

  def usage_status product
    usage_manifest_for(product).try(:status)
  end

  def use! product, status: :using
    usage_manifests.find_or_create_by(user: self, product: product).tap do |manifest|
      manifest.update(status: status)
    end
  end
end
