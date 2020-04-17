class Customer < ApplicationRecord
  has_secure_password :password
  validates :first_name, :last_name, :email, :address, :phone_number, presence: true
  validates_format_of :email, with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
  validates :email, uniqueness: { case_sensitive: false }
  has_one_attached :cust_image

  has_many :order_details
  belongs_to :province
end
