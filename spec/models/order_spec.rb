require 'rails_helper'

RSpec.describe Order, type: :model do
  describe '#associations' do
    it { is_expected.to belong_to(:merchant) }
    it { is_expected.to belong_to(:shopper) }
  end

  describe '#validations' do
    it { is_expected.to validate_numericality_of(:amount).is_greater_than(0.0) }
  end
end
