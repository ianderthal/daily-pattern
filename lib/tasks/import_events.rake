require "csv"

def parse_shorthand_time(str)
  match = str.match(/\A(\d{1,2})(?::(\d{2}))?([ap])\z/i)
  raise "Unrecognized time format: #{str.inspect}" unless match

  hour = match[1].to_i
  minute = match[2].to_i
  meridian = match[3].downcase

  hour = 0 if meridian == "a" && hour == 12
  hour += 12 if meridian == "p" && hour != 12

  Time.zone.local(2000, 1, 1, hour, minute)
end

task import_events: :environment do
  Event.destroy_all

  csv_path = Rails.root.join("lib", "data", "events_import.csv")

  CSV.foreach(csv_path, headers: true) do |row|
    next if row["Date"].blank?

    date = Date.strptime(row["Date"], "%m/%d/%Y")
    time = parse_shorthand_time(row["Time"])

    Event.create!(date: date, time: time, comment: row["Notes"])
  end

  puts "Imported #{Event.count} events"
end
