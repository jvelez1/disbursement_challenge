# hello-scheduler.rb


class DisbursementsProcessorWorker
  include Sidekiq::Worker

  def perform(merchant_id, start_date, end_date)
    merchant = Merchant.find(merchant_id)
    return if merchant.nil?

    Rails.logger.info "--- DisbursementsProcessorWorker for merchant: #{merchant.id}  ---"
    Disbursements::Processor.new(merchant: merchant, start_date: start_date, end_date: end_date).call
  end
end
