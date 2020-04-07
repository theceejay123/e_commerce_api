json.extract! customer, :id, :first_name, :last_name, :email, :address, :phone_number

json.image_url url_for(customer.cust_image)
json.thumbnail_url rails_representation_url(customer.cust_image.variant(resize: "200x200").processed, only_path: true)
