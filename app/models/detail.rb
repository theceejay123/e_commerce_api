class Detail < ApplicationRecord
  belongs_to :order_detail
  belongs_to :product
end
