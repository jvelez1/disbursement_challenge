class Order < ApplicationRecord
  belongs_to :merchant
  belongs_to  :shopper

  validates :amount, presence: true, numericality: { greater_than: 0.0 }
end
