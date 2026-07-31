require "csv"

task import_events: :environment do
  csv_path = Rails.root.join("lib", "data", "events_import.csv")

  CSV.foreach(csv_path, headers: true) do |row|
    next if row["Date"].blank?

    puts "#{row['Date']} | #{row['Time']} | #{row['Notes']}"
  end
end
