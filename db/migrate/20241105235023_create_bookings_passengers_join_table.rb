class CreateBookingsPassengersJoinTable < ActiveRecord::Migration[7.2]
  def change
    create_table :bookings_passengers, id: false do |t|
      t.belongs_to :booking
      t.belongs_to :passenger
    end

    add_index :bookings_passengers, [ :booking_id, :passenger_id ], unique: true
  end
end
