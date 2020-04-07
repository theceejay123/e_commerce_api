json.extract! tax, :id, :name, :tax

json.province do
  json.id tax.province.id
  json.name tax.province.name
end

json.url tax_url(tax)
