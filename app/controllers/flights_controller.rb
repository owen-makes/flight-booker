class FlightsController < ApplicationController
  def index
    @airports = Airport.order(:airport_code)
    @flights = params[:search] ? Flight.search(params[:search]) : Flight.none
  end

  def show
  end

  private

  def flight_parms
    params.require(:flight).permit(:date, :duration,
                                  departure_airport_attributes: [ :id, :airport_code ],
                                  arrival_airport_attributes: [ :id, :airport_code ])
  end
end
