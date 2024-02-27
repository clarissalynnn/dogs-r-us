class DogsController < ApplicationController

  skip_before_action :authenticate_user!, only: :index

  def index
    # @dogs = Dog.by_breed_and_personality(params[:breed], params[:personality])
    @dogs = Dog.all
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
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def dogs_params
    params.require(:dog).permit(:name, :breed, :personality, :photos, :date_of_birth)
  end

end
