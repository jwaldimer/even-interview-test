class Api::ReleasesController < ApplicationController
  def index
    result = Releases::Index.call(params: index_params)

    if result.success?
      render_success(result.payload)
    else
      render_error(result)
    end
  end

  def create
    # TODO:
  end

  private
  def index_params
    params.permit(Release::INDEX_PARAMS)
  end

end
