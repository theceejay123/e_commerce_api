json.extract! order_detail, :id, :reference_number, :total, :historical_tax, :customer_id, :created_at, :updated_at
json.url order_detail_url(order_detail, format: :json)
