module Releases
  class BuildScope < ApplicationInteractor
    
    def call
      context.scope =
        Release
          .includes(:artists, :album)
          .order(released_at: :desc, id: :desc)
    end
  end
end
