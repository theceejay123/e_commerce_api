class Tax < ApplicationRecord
  validates :name, :tax, presence: true
  belongs_to :province
end
