json.extract! detail, :id, :price, :quantity, :order_detail_id, :product_id, :created_at, :updated_at
json.url detail_url(detail, format: :json)
