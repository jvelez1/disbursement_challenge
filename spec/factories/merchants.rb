FactoryBot.define do
  factory :merchant do
    email { FFaker::Internet.unique.email }
    cif { FFaker::Code.npi }
  end
end
