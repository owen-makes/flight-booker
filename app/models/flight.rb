class Flight < ApplicationRecord
  belongs_to :departure_airport, class_name: "Airport", foreign_key: "departure_airport_id"
  belongs_to :arrival_airport, class_name: "Airport", foreign_key: "arrival_airport_id"

  def self.search(params)
    flights = all  # Start with all flights

    # Only add conditions for parameters that are present
    flights = flights.where(departure_airport_id: params[:departure_airport_id]) if params[:departure_airport_id].present?
    flights = flights.where(arrival_airport_id: params[:arrival_airport_id]) if params[:arrival_airport_id].present?

    # For the date, use the month/year
    flights = flights.search_by_month(params[:date]) if params[:date].present?

    flights = flights.where("seats_available >= ?", params[:seats_available])

    flights  # Return the filtered results
  end

  def self.get_flight_dates
    select("DISTINCT strftime('%Y-%m-01', date) AS flight_date")
      .where.not(date: nil)
      .order("flight_date ASC")
  end

  def flight_date_formatted
    Date.parse(flight_date).strftime("%B %Y")
  end

  def flight_date_value
    Date.parse(flight_date).strftime("%Y-%m")  # Will return "2024-10"
  end

  def self.search_by_month(year_month)
    year, month = year_month.split("-")
    where("strftime('%Y', date) = ? AND strftime('%m', date) = ?",
          year, month)
  end
end
