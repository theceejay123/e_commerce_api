json.extract! province, :id, :name

json.taxes(province.taxes) do |tax|
  json.id tax.id
  json.name tax.name
  json.tax tax.tax
end

json.url province_url(province)
