class CreateBookings < ActiveRecord::Migration[7.2]
  def change
    create_table :bookings do |t|
      t.timestamps
      t.references :flight
      t.references :passenger
    end
  end
end
