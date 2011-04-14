class Genre < ActiveRecord::Base
  validates :name, :presence => true
  
  has_many :listens_to
  has_many :users, :through => :listens_to
  
  acts_as_nested_set
end
