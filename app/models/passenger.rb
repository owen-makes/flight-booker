class Passenger < ApplicationRecord
  has_and_belongs_to_many :bookings
  validates :name, :email, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
end
