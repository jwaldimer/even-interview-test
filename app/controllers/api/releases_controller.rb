class Api::ReleasesController < ApplicationController
  def index
    result = Releases::Index.call(params: index_params)

    if result.success?
      render json: result.payload, status: :ok
    else
      render json: { 
        error: result.error,
        details: result.details
      }, status: :unprocessable_entity
    end
  end

  def create
    # TODO:
  end

  private
  def index_params
    params.permit(:past, :limit, :page)
  end

end
