class User < ActiveRecord::Base
  validates :lastfm_username, :presence => true, :uniqueness => true
  
  has_one :programmer
  has_one :designer
  has_many :genres, :through => :listens_to
  
  def music
    @lastfm ||= DubstepMakesYou::LastFM.new lastfm_username
  end
  
  def is_programmer?
    !self.programmer.nil?
  end
  
  def is_designer?
    !self.designer.nil?
  end
end