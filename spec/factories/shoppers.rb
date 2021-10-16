FactoryBot.define do
  factory :shopper do
    email { FFaker::Internet.unique.email }
    nif { FFaker::Code.npi }
  end
end
