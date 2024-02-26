class DogsController < ApplicationController
  def index
    @dogs = Dog.by_breed_and_personality(params[:breed], params[:personality])
  end
end
