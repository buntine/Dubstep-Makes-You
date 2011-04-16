class Designer < ActiveRecord::Base
  validates :dribbble_username, :presence => true, :uniqueness => true
  belongs_to :user
  attr_reader :account
  
  def account
  end
end
