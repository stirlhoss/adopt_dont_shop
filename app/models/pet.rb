class Pet < ApplicationRecord
  validates :name, presence: true
  validates :age, presence: true, numericality: true
  belongs_to :shelter
  has_many :pet_applications
  has_many :applications, through: :pet_applications

  def shelter_name
    shelter.name
  end

  def self.adoptable
    where(adoptable: true)
  end

  def self.avg_age
    where(adoptable: true).average(:age).to_f
  end

  def self.number_of_pets
    where(adoptable: true).count
  end

  def self.number_of_adopted
    where(adoptable: false).count
  end
end
