class Location < ActiveRecord::Base
  has_many :meetups

  validates :name, presence: true
  validates :name, uniqueness: { scope: :address }
end
