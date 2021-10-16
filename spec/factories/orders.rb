FactoryBot.define do
  factory :order do
    merchant
    shopper
    amount { 10.02 }
  end
end
