module Disbursements
  class Processor
    def initialize(merchant:, start_date:, end_date:)
      @merchant = merchant
      @start_date = start_date
      @end_date = end_date
    end

    def call
      merchant.orders.completed_in(start_date, end_date).find_in_batches(batch_size: 50) do |orders|
        orders.each do |order|
          Disbursements::Creator.new(
            merchant_id: merchant.id,
            order_id: order.id,
            fee_calculator: FeeCalculator.new(amount: order.amount)
          ).call
        end
      end
    end

    private

    attr_reader :merchant, :start_date, :end_date
  end
end
