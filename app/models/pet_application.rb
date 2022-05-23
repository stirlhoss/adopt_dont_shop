class PetApplication < ApplicationRecord
   belongs_to :pet
   belongs_to :application

   def self.pet_app_find(applicationid,petid)
     PetApplication.where("application_id = ? and pet_id = ?", applicationid, petid).first
   end

 end
