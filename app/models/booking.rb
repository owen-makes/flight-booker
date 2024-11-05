class Booking < ApplicationRecord
  has_and_belongs_to_many :passengers
  has_one :flight
end
