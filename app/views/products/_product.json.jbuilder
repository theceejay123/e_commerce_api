json.extract! product, :id, :name, :description, :price
json.photographer do
  json.id product.photographer.id
  json.name product.photographer.full_name
end
json.category do
  json.id product.category.id
  json.name product.category.id
end
