json.extract! product, :id, :name, :description, :price

json.photographer do
  json.id product.photographer.id
  json.name product.photographer.full_name
end

json.category do
  json.id product.category.id
  json.name product.category.id
end

json.image_url url_for(product.prod_image)
json.thumbnail_url rails_representation_url(product.prod_image.variant(resize: "200x200").processed, only_path: true)
