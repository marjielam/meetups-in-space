class Meetup < ActiveRecord::Base
  belongs_to :location
  belongs_to :creator, class_name: :User
  has_many :commitments
  has_many :users, :through => :commitments

  validates :name, presence: true
  validates :name, uniqueness: { scope: :location }
  validates :description, presence: true
  validates :location, presence: true
  validates :creator, presence: true
end
