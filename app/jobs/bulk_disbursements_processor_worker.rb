# hello-scheduler.rb

require 'sidekiq-scheduler'

class BulkDisbursementsProcessorWorker
  include Sidekiq::Worker

  def perform
    Rails.logger.info '--- BulkDisbursementsProcessorWorker ---'
    start_date = (Date.current - 1.week).beginning_of_day
    end_date = (Date.current - 1.day).end_of_day
    Merchant.select(:id).find_in_batches(batch_size: 50) do |merchants|
      merchants.pluck(:id).each do |merchant_id|
        DisbursementsProcessorWorker.perform_async(merchant_id, start_date, end_date)
      end
    end

    Rails.logger.info 'ending --- BulkDisbursementsProcessorWorker ---'
  end
end
