require "rails_helper"

RSpec.describe "GET /api/releases", type: :request do
  it "returns releases in the expected format with meta" do
    artist = create(:artist, name: "Jane D")
    release = create(:release, name: "Sound Music", released_at: 2.days.ago)
    create(:album, release:, name: "Sound Music - Single", duration_in_minutes: 55)
    create(:artist_release, release:, artist:)

    get "/api/releases"

    expect(response).to have_http_status(:ok)

    body = JSON.parse(response.body)
    expect(body).to include("data", "meta")

    item = body["data"].first
    expect(item).to include(
      "id" => release.id,
      "name" => "Sound Music",
      "duration_in_minutes" => 55
    )

    expect(item["album"]).to eq({ "name" => "Sound Music - Single" })
    expect(item["artists"]).to eq([{ "id" => artist.id, "name" => "Jane D" }])

    expect(body["meta"]).to include("total_count", "limit", "page", "offset")
  end
end

RSpec.describe "GET /api/releases?past=", type: :request do
  it "returns only past releases when past=1" do
    past_release = create(:release, released_at: 2.days.ago)
    future_release = create(:release, released_at: 2.days.from_now)

    get "/api/releases", params: { past: 1 }

    ids = JSON.parse(response.body).fetch("data").map { |release| release["id"] }
    expect(ids).to contain_exactly(past_release.id)
    expect(ids).not_to include(future_release.id)
  end

  it "returns only upcoming releases when past=0" do
    past_release = create(:release, released_at: 2.days.ago)
    future_release = create(:release, released_at: 2.days.from_now)

    get "/api/releases", params: { past: 0 }

    ids = JSON.parse(response.body).fetch("data").map { |release| release["id"] }
    expect(ids).to contain_exactly(future_release.id)
    expect(ids).not_to include(past_release.id)
  end

  it "returns 422 for invalid past" do
    get "/api/releases", params: { past: "maybe" }

    expect(response).to have_http_status(:unprocessable_entity)
    body = JSON.parse(response.body)
    expect(body["error"]).to eq("INVALID_PAST")
  end
end

RSpec.describe "GET /api/releases pagination", type: :request do
  it "defaults to 10 records" do
    create_list(:release, 11)

    get "/api/releases"

    body = JSON.parse(response.body)
    expect(body["data"].size).to eq(10)
    expect(body["meta"]["total_count"]).to eq(11)
    expect(body["meta"]["limit"]).to eq(10)
  end

  it "supports limit parameter" do
    create_list(:release, 25)

    get "/api/releases", params: { limit: 20 }

    body = JSON.parse(response.body)
    expect(body["data"].size).to eq(20)
    expect(body["meta"]["limit"]).to eq(20)
  end

  it "supports page parameter" do
    create_list(:release, 25)

    get "/api/releases", params: { limit: 10, page: 2 }

    body = JSON.parse(response.body)
    expect(body["data"].size).to eq(10)
    expect(body["meta"]["page"]).to eq(2)
    expect(body["meta"]["offset"]).to eq(10)
  end
end
