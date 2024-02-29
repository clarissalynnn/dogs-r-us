class DogsController < ApplicationController
  skip_before_action :authenticate_user!, only: :index
  before_action :set_dog, only: [:show]

  def index
    # @dogs = Dog.by_breed_and_personality(params[:breed], params[:personality])
    if user_signed_in? && params[:show_my_dogs] == "true"
      @dogs = current_user.dogs
    else
      @dogs = Dog.all
    end
  end

  def filter
    filtered_data = Dog.where(breed: params[:values])
    json_value = filtered_data.map do |dog|
      render_to_string(partial: "dogs/card", formats: :html, locals: {dog: dog})
    end
    render json: json_value
  end

  def show
  end

  def new
    @dog = Dog.new
  end

  def create
    @dog = current_user.dogs.build(dogs_params)
    if @dog.save
      redirect_to user_profile_path(current_user), notice: 'Dog was successfully created.' # Success message after the redirect.
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @dog = Dog.find(params[:id])
    @dog.destroy
    redirect_to dogs_path, notice: "Dog was successfully deleted."
  end

  private

  def set_dog
    @dog = Dog.find(params[:id])
  end

  def dogs_params
    params.require(:dog).permit(:name, :breed, :personality, :photos, :date_of_birth)
  end
end
