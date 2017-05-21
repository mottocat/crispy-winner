class AddApprovedImageIdToUsageManifests < ActiveRecord::Migration[5.0]
  def change
    add_column :usage_manifests, :approved_image_id, :integer
  end
end
