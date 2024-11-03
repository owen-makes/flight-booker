class FlightsController < ApplicationController
  def index
    @airports = Airport.order(:airport_code)
    @flights = if params[:departure_airport_id] || params[:arrival_airport_id] || params[:date] || params[:seats_available]
      Flight.search(params)
    else
      Flight.none
    end
  end

  def show
  end

  private

  def flight_parms
    params.require(:flight).permit(:date, :duration, :seats_available,
                                  departure_airport_attributes: [ :id, :airport_code ],
                                  arrival_airport_attributes: [ :id, :airport_code ])
  end
end
