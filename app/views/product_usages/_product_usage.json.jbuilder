json.extract! product_usage, :id, :user_id, :product_name, :usage_status, :images, :comment_body, :created_at, :updated_at
json.url product_usage_url(product_usage, format: :json)