class BookingsController < ApplicationController

  def index
    @user = current_user
    @bookings_as_renter = @user.bookings # bookings that belong to renter
    @dogs_owned_by_user = Dog.where(user_id: @user.id) # get all dogs owned by the current_user
    @bookings_as_owner = Booking.where(dog_id: @dogs_owned_by_user.pluck(:id)) # get all bookings associated with the owner's dogs
  end

  def show
    @booking = Booking.find(params[:id])
    @age = ((Date.today - @booking.dog.date_of_birth.to_date) / 365).to_i
    @days = ((@booking.end_date) - (@booking.start_date)).round
  end


  def owner
    @booking = Booking.find(params[:id])
    @dog = Dog.find(@booking.dog_id) # owner's dog
    @renter = User.find(@booking.user_id)
    @days = ((@booking.end_date) - (@booking.start_date)).round
  end

  def accept
    @booking = Booking.find(params[:id])
    if @booking.update(status: 'Approved')
      flash[:notice] = "Booking approved ✅"
    else
      redirect_to booking_path(@booking)
    end
  end

  def decline
    @booking = Booking.find(params[:id])
    if @booking.update(status: 'Declined')
      flash[:alert] = "Booking declined ❌"
    else
      redirect_to booking_path(@booking)
    end
  end

  def new
    @user = current_user
    @dog = Dog.find(params[:dog_id])
    @booking = Booking.new
  end

  def create
    @dog = Dog.find(params[:dog_id])
    @user = current_user
    @booking = Booking.new(booking_params)
    @booking.dog = @dog
    @booking.user = @user
    if @booking.save
      redirect_to  bookings_path
    else
      render :new,  status: :unprocessable_entity
    end
  end

  def edit
    @booking = Booking.find(params[:id])
  end

  def update
    @booking = Booking.find(params[:id])
    @booking.update(booking_params)
    if @booking.save
      redirect_to booking_path(@booking), notice: "Booking successfully updated"
    else
      render :edit, status:  :unprocessable_entity
    end
  end



  def destroy
    @booking = Booking.find(params[:id])
    @booking.destroy
    redirect_to  bookings_path, status: :see_other, notice: "Booking successfully cancelled"
  end

  private

  def booking_params
    params.require(:booking).permit(:start_date, :end_date, :status)
  end

end
