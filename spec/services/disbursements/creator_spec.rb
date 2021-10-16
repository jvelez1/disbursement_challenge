# frozen_string_literal: true

require 'rails_helper'

describe Disbursements::Creator do
  let(:merchant) { create(:merchant) }
  let(:order) { create(:order, amount: 150, merchant_id: merchant.id) }
  let(:fee_calculator) { Disbursements::FeeCalculator.new(amount: order.amount) }

  subject { described_class.new(merchant_id: merchant.id, order_id: order.id, fee_calculator: fee_calculator).call }

  describe '.call' do
    it 'creates a disbursement' do
      expect { subject }.to change(Disbursement, :count).from(0).to(1)
    end

    it 'creates a disbursement with valid attributes' do
      disbursement = subject
      expect(disbursement.fee).to eq(0.0095)
      expect(disbursement.total.to_f).to eq(151.43)
    end
  end
end
