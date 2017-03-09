class CreateProductUsages < ActiveRecord::Migration[5.0]
  def change
    create_table :product_usages do |t|
      t.references :user, foreign_key: true
      t.string :product_name
      t.integer :usage_status
      t.json :images
      t.text :comment_body

      t.timestamps
    end
  end
end
