class Shopper < ApplicationRecord
  include EmailValidable

  has_many :orders, dependent: :nullify

  validates :nif, presence: true, uniqueness: { case_sensitive: false }
end
