class Order < ApplicationRecord
  scope :completed_in, ->(start_date, end_date) { where(completed_at: start_date..end_date) }

  belongs_to :merchant
  belongs_to :shopper
  has_one :disbursement

  validates :amount, presence: true, numericality: { greater_than: 0.0 }
end
