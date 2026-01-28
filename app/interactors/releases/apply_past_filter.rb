module Releases
  class ApplyPastFilter < ApplicationInteractor

    def call
      return if context.past.nil?

      now = Time.current
      filter = context.past ? "<" : ">="

      context.scope = context.scope.where("releases.released_at #{filter} ?", now)
    end
  end
end
