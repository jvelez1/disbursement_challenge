# frozen_string_literal: true

require 'rails_helper'

describe Disbursements::FeeCalculator do
  subject { described_class.new(amount: amount).call }

  describe ".call" do
    context 'when amount is less than 50' do
      let(:amount) { 35 }

      it 'calculates fee as 0.01' do
        result = subject
        expect(result.fee).to eq(0.01)
        expect(result.total).to eq(35.35)
      end
    end

    context 'when amount is between 50 and 300' do
      context 'when amount is 50' do
        let(:amount) { 50 }
        it 'calculates fee as 0.0095' do
          result = subject
          expect(result.fee).to eq(0.0095)
          expect(result.total).to eq(50.475)
        end
      end

      context 'when amount over 50 and less than 300' do
        let(:amount) { 230 }
        it 'calculates fee as 0.0095' do
          result = subject
          expect(result.fee).to eq(0.0095)
          expect(result.total).to eq(232.185)
        end
      end

      context 'when amount  is 300' do
        let(:amount) { 300 }
        it 'calculates fee as 0.0095' do
          result = subject
          expect(result.fee).to eq(0.0095)
          expect(result.total).to eq(302.85)
        end
      end
    end

    context 'when amount is over 300' do
      let(:amount) { 400.45 }

      it 'calculates fee as 0.0085' do
        result = subject
        expect(result.fee).to eq(0.0085)
        expect(result.total).to eq(403.853825)
      end
    end
  end
end
