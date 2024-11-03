  # This file should ensure the existence of records required to run the application in every environment (production,
  # development, test). The code here should be idempotent so that it can be executed at any point in every environment.
  # The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
  #
  # Example:
  #
  [ "SFO", "EZE", "GRU", "LAX", "BKK", "JFK", "MIA", "DXB", "BCN", "LDN", "SYD", "HND" ].each do |code|
    Airport.find_or_create_by!(airport_code: code)
  end

  # Create flights for the next 30 days
  puts "Creating flights..."

  airports = Airport.all
  dates = (Date.today..30.days.from_now).to_a
  flight_durations = {
    # Durations in hours:minutes format
    domestic: [ '02:00', '03:30', '04:00' ],
    short_international: [ '06:00', '07:30', '08:00' ],
    long_international: [ '11:00', '13:30', '15:00' ]
  }

  # Create several flights per day between different airport pairs
  airports.each do |departure_airport|
    (airports - [ departure_airport ]).each do |arrival_airport|
      dates.each do |date|
        # Create 2-3 flights per route per day
        rand(2..3).times do
          # Determine flight duration based on airports
          duration_category = case
          when [ 'SFO', 'LAX', 'JFK', 'MIA' ].include?(departure_airport.airport_code) &&
                [ 'SFO', 'LAX', 'JFK', 'MIA' ].include?(arrival_airport.airport_code)
              :domestic
          when [ 'EZE', 'GRU', 'BKK', 'DXB', 'BCN', 'LDN', 'SYD', 'HND' ].include?(departure_airport.airport_code) ||
                [ 'EZE', 'GRU', 'BKK', 'DXB', 'BCN', 'LDN', 'SYD', 'HND' ].include?(arrival_airport.airport_code)
              :long_international
          else
              :short_international
          end

          Flight.create!(
            departure_airport: departure_airport,
            arrival_airport: arrival_airport,
            date: date.to_datetime + rand(6..22).hours + [ 0, 15, 30, 45 ].sample.minutes,
            duration: flight_durations[duration_category].sample,
            seats_available: rand(1..100).to_i
          )
        end
      end
    end
  end

  puts "Created #{Flight.count} flights"
