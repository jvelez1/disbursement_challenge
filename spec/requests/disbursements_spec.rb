require 'rails_helper'

RSpec.describe 'Disbursements', type: :request do
  let(:merchant) { create(:merchant) }
  let(:merchant_two) { create(:merchant) }
  let!(:disbursement) { create(:disbursement, merchant_id: merchant.id, total: 200) }
  let!(:disbursement_two) { create(:disbursement, merchant_id: merchant_two.id, total: 300) }

  describe 'GET' do
    context 'when no merchant_id' do
      it 'returns all disbursements' do
        get '/disbursements'
        expect(response).to have_http_status(200)
        resp = parsed_response(response.body)
        expect(resp['RECORDS'].count).to eq(2) 
      end
    end

    context 'when merchant_id' do
      it 'returns all disbursements for given merchant' do
        get '/disbursements', params: { merchant_id: merchant.id }
        expect(response).to have_http_status(200)
        resp = parsed_response(response.body)
        expect(resp['RECORDS'].count).to eq(1)
        expect(resp['RECORDS'].first).to match(
          hash_including({
            'id' => disbursement.id,
            'fee' => 0.95,
            'merchant_id' => merchant.id,
            'order_id' => disbursement.order_id,
            'total' => '200.0'
          })
        )
      end

      it 'returns empty when given start_date and end_date' do
        get '/disbursements', params: { merchant_id: merchant.id, start_date: Date.current - 1.week, end_date: Date.current - 1.day }
        expect(response).to have_http_status(200)
        resp = parsed_response(response.body)
        expect(resp['RECORDS'].count).to eq(0)
      end
    end
  end

  describe 'POST' do
    context 'when no merchant_id' do
      it 'returns 422' do
        post '/disbursements'
        expect(response).to have_http_status(422)
        resp = parsed_response(response.body)
        expect(resp).to eq({ 'error' => 'Mercant not valid' })
      end
    end

    context 'when merchant_id' do
      it 'returns 200' do
        post '/disbursements', params: { merchant_id: merchant.id }
        expect(response).to have_http_status(200)
        resp = parsed_response(response.body)
        expect(resp).to include(
          {
            'start_date' => be_an(String),
            'end_date' => be_an(String),
            'merchant_id' => merchant.id,
            'status' => 'calculating'
          }
        )
      end
    end
  end

  def parsed_response(body)
    JSON.parse(body).to_h
  end
end
