require 'rails_helper'

RSpec.describe "Events", type: :request do
  it "creates an event and redirects" do
    expect {
      post events_path, params: { event: { date: Date.current, time: Time.current, comment: "test " } }
  }.to change(Event, :count).by(1)
    expect(response).to redirect_to(root_path)
  end

  it "returns grouped counts as json from heatmap_data" do
    Event.create!(date: Date.new(2026, 7, 1), time: Time.current)
    Event.create!(date: Date.new(2026, 7, 1), time: Time.current)
    Event.create!(date: Date.new(2026, 7, 2), time: Time.current)

    get heatmap_data_events_path
    body = JSON.parse(response.body)

    expect(body).to eq(
      [
        { "date" => "2026-07-01", "value" => 2 },
        { "date" => "2026-07-02", "value" => 1 }
      ]
    )
  end
end