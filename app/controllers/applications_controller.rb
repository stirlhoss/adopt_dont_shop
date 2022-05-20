class ApplicationsController < ApplicationController
   def index
     @applications = Application.all
   end

   def show
     @application = Application.find(params[:id])
   end

   def new
     # @application = Application.find(params[:id])
   end

   def create
     application = Application.create(app_params)
      if application.save
        redirect_to "/applications/#{application.id}"
      else
        flash[:error] = "Error: Please Fill in ALL Fields"
        redirect_to '/applications/new'
      end
    end

   private
   def app_params
     params.permit(:name,:address,:city,:state,:zipcode,:description, :status)
   end
 end
