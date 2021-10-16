class Merchant < ApplicationRecord
  include EmailValidable

  has_many :orders, dependent: :nullify

  validates :cif, presence: true, uniqueness: { case_sensitive: false }
end
