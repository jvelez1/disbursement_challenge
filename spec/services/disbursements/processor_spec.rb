# frozen_string_literal: true

require 'rails_helper'

describe Disbursements::Processor do
  let(:start_date) { DateTime.current }
  let(:end_date) { DateTime.current + 1.week }
  let(:merchant) { create(:merchant) }
  let!(:order_one) { create(:order, amount: 150, merchant_id: merchant.id, completed_at: start_date) }
  let!(:order_two) { create(:order, amount: 30, merchant_id: merchant.id, completed_at: nil) }
  let!(:order_three) { create(:order, amount: 30, merchant_id: merchant.id, completed_at: end_date) }

  subject { described_class.new(merchant: merchant, start_date: start_date, end_date: end_date).call }

  describe '.call' do
    it 'creates 2 disbursements' do
      expect { subject }.to change(Disbursement, :count).from(0).to(2)
    end
  end
end
