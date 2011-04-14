class Genre < ActiveRecord::Base
  validates :name, :presence => true
  acts_as_nested_set
end
