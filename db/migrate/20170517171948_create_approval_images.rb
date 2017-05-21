class CreateApprovalImages < ActiveRecord::Migration[5.0]
  def change
    create_table :approval_images do |t|
      t.references :user, foreign_key: true
      t.references :product, foreign_key: true
      t.string :image
      t.integer :status, default: 0

      t.timestamps
    end

    add_index :approval_images, [:user_id, :product_id], unique: true
  end
end
