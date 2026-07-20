require 'rails_helper'

RSpec.describe Event, type: :model do
  it "is invalid without a date" do
    event = Event.new(time: Time.current, comment: "test")
    expect(event).not_to be_valid
  end

  it "is invalid without a time" do
    event = Event.new(date: Date.current, comment: "test")
    expect(event).not_to be_valid
  end

  it "is valid with date and time only" do
    event = Event.new(date: Date.current, time: Time.current)
    expect(event).to be_valid
  end
end
