class Customer < ApplicationRecord
  validates :first_name, :last_name, :email, :address, :phone_number, presence: true
  has_one_attached :cust_image

  has_many :order_details
  belongs_to :province
end
