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
     redirect_to "/applications/#{application.id}"
   end

   private
   def app_params
     params.permit(:name,:address,:city,:state,:zipcode,:description, :status)
   end
 end
