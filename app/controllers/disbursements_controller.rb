class DisbursementsController < ApplicationController
  def index
    disbursements = if merchant.present?
      merchant.disbursements.in_range(start_date, end_date)
    else
      Disbursement.in_range(start_date, end_date)
    end

    render json: { RECORDS: disbursements }
  end

  def create
    raise 'Mercant not valid' if merchant.nil?

    DisbursementsProcessorWorker.perform_async(
      merchant.id,
      start_date,
      end_date
    )

    render json: { start_date: start_date, end_date: end_date, merchant_id: merchant.id, status: :calculating }
  end


  private

  def disbursement_params
    params.permit(:merchant_id, :start_date, :end_date)
  end

  def merchant
    @merchant ||= Merchant.find_by(id: merchant_id) if merchant_id.present?
  end

  def merchant_id
    disbursement_params[:merchant_id]
  end

  def start_date
    date = disbursement_params[:start_date]
    date.present? ? parse_date(date) : DateTime.current - 1.week
  end

  def end_date
    date = disbursement_params[:end_date]
    date.present? ? parse_date(date) : DateTime.current
  end
end
