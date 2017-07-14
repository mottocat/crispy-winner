class Forest::Comment
  include ForestLiana::Collection

  collection :comments

  belongs_to :related_approval_image, reference: 'approval_images.id' do
    ApprovalImage.find_by(product: object.product, user: object.author)
  end

  belongs_to :related_usage_manifest, reference: 'usage_manifests.id' do
    UsageManifest.find_by(product: object.product, user: object.author)
  end

end