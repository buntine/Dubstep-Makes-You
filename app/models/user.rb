class User < ActiveRecord::Base
  validates :lastfm_username, :presence => true, :uniqueness => true
  
  has_one :programmer
  has_one :designer
  has_many :listens_to
  has_many :genres, :through => :listens_to
  
  before_save :update_genres
  
  def music
    @lastfm ||= DubstepMakesYou::LastFM.new lastfm_username
  end
  
  def is_programmer?
    !self.programmer.nil?
  end
  
  def is_designer?
    !self.designer.nil?
  end
  
  private
  
  def update_genres
    self.genres = Genre.where(:name => self.music.genres).all
  end
end
