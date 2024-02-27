class BookingsController < ApplicationController

  def index
    @user = current_user
    @bookings = @user.bookings
  end

  def new
    @dog = Dog.find(params[:dog_id])
    @user = current_user
    @booking = Booking.new

  end

  def create
    @dog = Dog.find(params[:dog_id])
    @user = current_user
    @booking = Booking.new(booking_params)
    @booking.dog = @dog
    @booking.user = @user

    if @booking.save
      redirect_to  user_bookings_path(:user_id)
    else
      render :new,  status: :unprocessable_entity
    end
end

  private

  def booking_params
    params.require(:booking).permit(:start_date, :end_date, :status)
  end

end
