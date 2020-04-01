class Customer < ApplicationRecord
  has_one_attached :cust_image

  belongs_to :province
end
