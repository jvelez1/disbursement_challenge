FactoryBot.define do
  factory :disbursement do
    merchant
    order
    fee { 0.95 }
  end
end
