class ApplicationController < ActionController::API

  private
  def render_success(payload, status: :ok)
    render json: payload, status: status
  end

  def render_error(object, status: :unprocessable_entity)
    render json: { 
      error: object.error,
      details: object.details
    }, status: status
  end
end
