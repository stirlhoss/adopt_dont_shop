class Admin::SheltersController < ApplicationController
  def index
    @shelters = Shelter.order_by_name_desc
    @pending_shelters = Shelter.show_pending.pending_abc
  end

  def show
    @shelter = Shelter.only_name_and_city(params[:id])
    @shelter_all = Shelter.find(params[:id])
    @pets = @shelter_all.pets
    @pending_pets = @shelter_all.show_pending_pets
  end
end
