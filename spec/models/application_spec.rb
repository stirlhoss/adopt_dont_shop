require 'rails_helper'

RSpec.describe Application, type: :model do
  describe 'relationships' do
    it { should have_many :pet_applications }
    it { should have_many(:pets).through(:pet_applications) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:address) }
    it { should validate_presence_of(:city) }
    it { should validate_presence_of(:state) }
    it { should validate_presence_of(:zipcode) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:status) }
  end

  describe 'instance methods' do
    before :each do
      @shelter_1 = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
      @pet_1 = @shelter_1.pets.create!(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: true)
      @pet_2 = @shelter_1.pets.create!(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)
      @application_1 = Application.create!(name: 'Mike', address: '1234 Street St', city: 'Denver', state: 'CO',
                                           zipcode: '69420', description: 'I care about pets', status: 'In Progress')
      @pet_application_1 = PetApplication.create!(application: @application_1, pet: @pet_2)
      @pet_application_2 = PetApplication.create!(application: @application_1, pet: @pet_1)
    end

    it 'approves application when all pets are approved' do
      @pet_application_1.status = "Approved"
      @pet_application_2.status = "Approved"
      @pet_application_1.save
      @pet_application_2.save

      expect(@application_1.all_approved?).to eq(true)
    end

    it 'returns false if not all pets have a status' do
      @pet_application_1.status = "Approved"
      @pet_application_2.status = "Open"
      @pet_application_1.save
      @pet_application_2.save

      expect(@application_1.all_updated?).to eq(false)
    end

    it 'returns true if all pets have a status' do
      @pet_application_1.status = "Approved"
      @pet_application_2.status = "Rejected"
      @pet_application_1.save
      @pet_application_2.save

      expect(@application_1.all_updated?).to eq(true)
    end

    it 'changes pets adoptable attribute to false' do
      @application_1.no_longer_adoptable

      expect(@application_1.pets[0].adoptable).to eq(false)
      expect(@application_1.pets[1].adoptable).to eq(false)
    end
  end
end
