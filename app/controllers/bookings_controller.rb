class BookingsController < ApplicationController
  before_action :set_booking, only: [:show, :owner, :accept, :decline, :edit, :update, :destroy]
  before_action :set_user, only: [:index, :new, :create]

  def index
    @bookings_as_renter = @user.bookings.order(status: :desc) # bookings that belong to renter
    @dogs_owned_by_user = Dog.where(user_id: @user.id) # get all dogs owned by the current_user
    @bookings_as_owner = Booking.where(dog_id: @dogs_owned_by_user.pluck(:id)).order(status: :desc) # get all bookings associated with the owner's dogs
  end

  def show
    @age = ((Date.today - @booking.dog.date_of_birth.to_date) / 365).to_i
    @days = ((@booking.end_date) - (@booking.start_date)).round
  end


  def owner
    @dog = Dog.find(@booking.dog_id) # owner's dog
    @renter = User.find(@booking.user_id)
    @owner = User.find(@dog.user_id) # The owner is the user associated with the dog
    @days = ((@booking.end_date) - (@booking.start_date)).round
  end

  def accept
    if @booking.update(status: "Approved")
      flash[:notice] = "Booking approved ✅"
    end
    redirect_to bookings_path
  end

  def decline
    if @booking.update(status: "Declined")
      flash[:alert] = "Booking declined ❌"
    end
    redirect_to bookings_path
  end

  def new
    @user = current_user
    @dog = Dog.find(params[:dog_id])
    @booking = Booking.new
    @ongoing_bookings = @user.bookings.select { |booking| booking.end_date > Date.today }.count
  end

  def create
    @dog = Dog.find(params[:dog_id])
    @booking = Booking.new(booking_params)
    @booking.status = "Pending"
    @booking.dog = @dog
    @booking.user = @user
    if @booking.save
      redirect_to  bookings_path
    else
      render :new,  status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    @booking.update(booking_params)
    if @booking.save
      redirect_to booking_path(@booking), notice: "Booking successfully updated"
    else
      render :edit, status:  :unprocessable_entity
    end
  end



  def destroy
    @booking.destroy
    redirect_to  bookings_path, status: :see_other, notice: "Booking successfully cancelled"
  end

  private

  def set_booking
    @booking = Booking.find(params[:id])
  end

  def set_user
    @user = current_user
  end

  def booking_params
    params.require(:booking).permit(:start_date, :end_date, :status)
  end

end
