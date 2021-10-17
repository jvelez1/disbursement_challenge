class ApplicationController < ActionController::API
  rescue_from StandardError, with: :rescue_with_error

  def parse_date(date_to_parse)
    DateTime.parse(date_to_parse)
  end

  private

  def rescue_with_error(exception)
    render json: { error: exception.to_s }, status: :unprocessable_entity
  end
end
