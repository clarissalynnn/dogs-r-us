class BookingsController < ApplicationController

  def new
    @dog = Dog.find(params[:dog_id])
    @user = User.find(params[:user_id])
    @booking = Booking.new(booking_params)

  end

  def create
    @dog = Dog.find(params[:dog_id])
    @user = User.find(params[:user_id])
    @booking = Booking.new(booking_params)
    @booking.dog = @dog
    @booking.user = @user

    if @booking.save
      redirect_to user_dog_bookings_path(@booking)
    else
      render :new_user_dog_booking_path  status: :unprocessable_entity

  end

  private

  def booking_params
    params.require(:booking).permit(:start_date, :end_date, :status)
  end

end
