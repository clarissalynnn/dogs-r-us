class DogsController < ApplicationController
  before_action :authenticate_user!, except: :index
  before_action :set_dog, only: [:show]

  def index
    # @dogs = Dog.by_breed_and_personality(params[:breed], params[:personality])
    if current_user
      @dogs = current_user.dogs
    else
      @dogs = Dog.all
    end
  end

  def show
  end

  def new
    @dog = Dog.new
  end

  def create
    @dog = Dog.new(dogs_params)
    #Assigns current user as the owner of the dog being listed.
    @dog.owner = current_user
    if @dog.save
      # Redirect to root_path for now, change to show path once that is done.
      redirect_to root_path, notice: 'Dog was successfully created.' # Success message after the redirect.
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def set_dog
    @dog = Dog.find(params[:id])
  end

  def dogs_params
    params.require(:dog).permit(:name, :breed, :personality, :photos, :date_of_birth)
  end
end
