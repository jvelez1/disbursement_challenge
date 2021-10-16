module Disbursements
  class Creator
    def initialize(merchant_id:, order_id:, fee_calculator:)
      @merchant_id = merchant_id
      @order_id = order_id
      @fee_results = fee_calculator.call
    end

    def call
      Disbursement.create!(
        merchant_id: merchant_id,
        order_id: order_id,
        fee: fee_results.fee,
        total: fee_results.total
      )
    rescue => error
      Rails.logger.error error
    end

    private

    attr_reader :merchant_id, :order_id, :fee_results
  end
end
