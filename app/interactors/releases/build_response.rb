module Releases
  class BuildResponse < ApplicationInteractor

    def call
      context.payload = {
        data: context.records.map { |release| serialize_release(release) },
        meta: {
          total_count: context.total_count,
          limit: context.limit,
          page: context.page,
          offset: context.offset
        }
      }
    end

    private
    def serialize_release(release)
      album = release.album

      {
        id: release.id,
        name: release.name,
        album: { name: album.name },
        artists: release.artists.map { |artist| { id: artist.id, name: artist.name } },
        created_at: release.created_at.iso8601,
        released_at: release.released_at.iso8601,
        duration_in_minutes: album.duration_in_minutes
      }
    end
  end
end
