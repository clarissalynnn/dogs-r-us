class BookingsController < ApplicationController

  def index
    @user = User.first # placeholder
    # @user = User.find(params[:user_id]) complete code
    @bookings = @user.bookings
  end

  def new
    @dog = Dog.find(params[:dog_id])
    @user = User.first #placeholder
    @booking = Booking.new

  end

  def create
    @dog = Dog.find(params[:dog_id])
    @user = User.first #placeholder
    @booking = Booking.new(booking_params)
    @booking.dog = @dog
    @booking.user = @user

    if @booking.save
      redirect_to  user_bookings_path
    else
      render :new,  status: :unprocessable_entity
    end
end

  private

  def booking_params
    params.require(:booking).permit(:start_date, :end_date, :status)
  end

end
