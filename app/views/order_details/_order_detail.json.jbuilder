json.extract! order_detail, :id, :reference_number, :total, :historical_tax

json.customer do
  json.id order_detail.customer.id
  json.name order_detail.customer.name
  json.email order_detail.customer.email
end

json.url order_detail_url(order_detail)
