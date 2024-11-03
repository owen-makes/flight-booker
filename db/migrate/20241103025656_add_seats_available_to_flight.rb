class AddSeatsAvailableToFlight < ActiveRecord::Migration[7.2]
  def change
    add_column :flights, :seats_available, :integer
  end
end
