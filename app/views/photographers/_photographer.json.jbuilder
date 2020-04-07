json.extract! photographer, :id, :full_name, :description

json.products(photographer.products) do |product|
  json.id product.id
  json.name product.name
  json.category product.category.name
end

json.url photographer_url(photographer)
