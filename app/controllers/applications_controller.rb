class ApplicationsController < ApplicationController
  
   def show
     @application = Application.find(params[:id])

     @application.pets << Pet.find(params[:pet]) if params[:pet]
     @applied_pets = @application.pets

     if params[:search].present?
       @searched_pets = Pet.adoptable.search(params[:search])
     else
       @searched_pets
     end
   end

   def new
   end

   def create
     @application = Application.create(app_params)
      if @application.save
        redirect_to "/applications/#{@application.id}"
      else
        flash[:error] = "Error: Please Fill in ALL Fields"
        redirect_to '/applications/new'
      end
    end

    def update
      @application = Application.find(params[:id])
      @application.description = params[:fill_description]
      @application.status = "Pending"
      @application.save
      redirect_to "/applications/#{@application.id}"
    end

   private
   def app_params
     params.permit(:name,:address,:city,:state,:zipcode,:description, :status)
   end
 end
