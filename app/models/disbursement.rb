class Disbursement < ApplicationRecord
  belongs_to :merchant
  belongs_to :order

  validates :total, presence: true, numericality: { greater_than: 0.0 }
  validates :fee, presence: true, numericality: { greater_than: 0.0 }
  validates_uniqueness_of :merchant_id, scope: [:order_id]
end
