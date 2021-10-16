require 'rails_helper'

RSpec.describe Disbursement, type: :model do
  describe '#associations' do
    it { is_expected.to belong_to(:merchant) }
    it { is_expected.to belong_to(:order) }
  end

  describe '#validations' do
    it { is_expected.to validate_numericality_of(:total).is_greater_than(0.0) }
    it { is_expected.to validate_numericality_of(:fee).is_greater_than(0.0) }
    it do
      expect(build(:disbursement))
        .to validate_uniqueness_of(:merchant_id).scoped_to(:order_id)
    end
  end
end
