class PassengerMailer < ApplicationMailer
  before_action :set_booking
  default from: "notifications@example.com"

  def confirmation_email(booking)
    @booking = booking
    mail(to: @booking.passengers.first.email, subject: "Here's your confirmation, #{@booking.passengers.first.name}!")
  end

  private

  def set_booking
  end
end
