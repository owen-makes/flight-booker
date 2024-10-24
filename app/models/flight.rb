class Flight < ApplicationRecord
  belongs_to :departure_airport, class_name: "Airport", foreign_key: "departure_airport_id"
  belongs_to :arrival_airport, class_name: "Airport", foreign_key: "arrival_airport_id"

  def self.search(params)
    self.where(
      departure_airport_id: params[:search][:departure_airport_id],
      arrival_airport_id: params[:search][:arrival_airport_id],
      date: params[:search][:date]
    )
  end
end
