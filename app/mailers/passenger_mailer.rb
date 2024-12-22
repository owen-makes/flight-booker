class PassengerMailer < ApplicationMailer
  default from: "notifications@example.com"

  def confirmation_email
    @passenger = params[:passenger]
    @flight = params[:flight]
    mail(to: @passenger.email, subject: "Here's your confirmation, #{@passenger.name}!")
  end
end
