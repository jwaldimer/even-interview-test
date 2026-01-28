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
        album: serialize_album(album),
        artists: release.artists.map { |artist| { id: artist.id, name: artist.name } },
        created_at: release.created_at.iso8601,
        released_at: release.released_at.iso8601,
        duration_in_minutes: album&.duration_in_minutes.to_i
      }
    end

    def serialize_album(album)
      return nil unless album

      { name: album.name }
    end
  end
end
