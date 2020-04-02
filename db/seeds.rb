# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

sizes_file = File.read('../sizes.json')
sizes = JSON.parse(sizes_file)

scraper = Scraper.new
taxes_by_province = scraper.scrape_taxes_by_province
photographers = scraper.scrape_photographers
categories = scraper.scrape_categories

pages = [
  {
    title: "About Us",
    content: "No Content",
    permalink: "about_us"
  },
  {
    title: "Contact Us",
    content: "No Content",
    permalink: "contact_us"
  }
]

# Seeding for photographers
photographers.each do |photographer|
  name = photographer[:name].split('(')[1].sub('@', '').sub(')', '').capitalize
  description = photographer[:description]

  Photographer.create(full_name: name, description: description)
end

# Seeding for provinces and taxes
taxes_by_province.each do |tax_by_province|
  province = tax_by_province[:province]
  province_obj = Province.create(name: province)
  taxes = tax_by_province[:tax_names]
  pst = tax_by_province[:prov_tax]
  gst = tax_by_province[:govt_tax]
  taxes.each do |tax|
    if (tax.strip == 'GST')
      province_obj.taxes.create(name: tax.strip, tax: gst)
    else
      province_obj.taxes.create(name: tax.strip, tax: pst)
    end
  end
end

# Seeding for categories
categories.each do |category|
  name = category[:name]
  description = category[:description]
  Category.create(name: name, description: description)
end

# Seeding for sizes - also using Faker
sizes.each do |size|
  name = Faker::Space.unique.star_cluster
  size = size["size"]
  Size.create(name: name, size: size)
end

# Seeding default pages
pages.each do |page|
  Page.create(title: page[:title], content: page[:content], permalink: page[:permalink])
end

puts ("Default Pages - #{Page.count}")
puts ("Photographers - #{Photographer.count}")
puts ("Province - #{Province.count}")
puts ("Taxes - #{Tax.count}")
puts ("Categories - #{Category.count}")
puts ("Sizes - #{Size.count}")
puts ("Products - #{Product.count}")

AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?