module Releases
  class ApplyPagination < ApplicationInteractor

    def call
      context.total_count = context.scope.size
      offset = (context.page - 1) * context.limit

      context.records =
        context.scope
               .offset(offset)
               .limit(context.limit)

      context.offset = offset
    end
  end
end
