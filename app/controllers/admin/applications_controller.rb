class Admin::ApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
  end

  def update
    @application = Application.find(params[:id])
    pet_application = PetApplication.pet_app_find(@application.id, params[:pet_id])
    pet_application.status = params[:pet_status]
    pet_application.save
    if @application.all_approved?
      @application.status = "Approved"
      @application.save
    end
    redirect_to "/admin/applications/#{@application.id}"
  end
end
