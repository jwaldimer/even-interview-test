module Releases
  class NormalizeParams < ApplicationInteractor
    DEFAULT_LIMIT = 10
    MAX_LIMIT = 100
    DEFAULT_PAGE = 1

    def call
      context.params = context.params.to_h

      context.past = normalize_past(context.params["past"])
      context.limit = normalize_limit(context.params["limit"])
      context.page = normalize_page(context.params["page"])
    end

    private
    def normalize_past(value)
      return nil if value.nil?

      case value.to_s
      when "1" then true
      when "0" then false
      else
        context.fail!(error: "INVALID_PAST", details: { past: value })
      end
    end

    def normalize_limit(value)
      limit = (value.presence || DEFAULT_LIMIT).to_i
      limit = DEFAULT_LIMIT if limit <= 0
      [limit, MAX_LIMIT].min
    end

    def normalize_page(value)
      page = (value.presence || DEFAULT_PAGE).to_i
      page = DEFAULT_PAGE if page <= 0
      page
    end
  end
end
