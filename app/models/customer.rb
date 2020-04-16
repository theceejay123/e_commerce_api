class Customer < ApplicationRecord
  has_secure_password
  validates :first_name, :last_name, :email, :password, :address, :phone_number, presence: true
  has_one_attached :cust_image

  has_many :order_details
  belongs_to :province
end
