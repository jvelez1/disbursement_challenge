module Disbursements
  class FeeCalculator
    FEE_RULES = {
      0.01 => lambda{ |value| value < 50 },
      0.0095 => lambda { |value| value >= 50 && value <= 300 },
      0.0085 => lambda { |value| value > 300 }
    }

    def initialize(amount:)
      @amount = amount
    end

    def call
      fee = FEE_RULES.find { |_, operation| operation.(amount) }.first
      total = amount + ( fee * amount )
      OpenStruct.new(fee: fee, total: total)
    end

    private

    attr_reader :amount
  end
end
