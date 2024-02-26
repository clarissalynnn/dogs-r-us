class DogsController < ApplicationController
  def index
    # @dogs = Dog.by_breed_and_personality(params[:breed], params[:personality])
    @dogs = Dog.all
  end

  def new
    @dog = Dog.new
  end

  def create
    @dog = Dog.new(dogs_params)
    if @dog.save
      raise
      # Redirect to root_path for now, change to show path once that is done.
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  private
  def dogs_params
    params.require(:dog).permit(:name, :breed, :personality, :photos)
  end
end
