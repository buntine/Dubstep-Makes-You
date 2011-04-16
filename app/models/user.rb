class User < ActiveRecord::Base
  belongs_to :user
  has_one :programmer
  
  attr_accessor :github_username, :dribbble_username, :lastfm_username
  
  def has_genres?
    self.designer.genres.empty? if designer
    self.programmer.genres.empty? if programmer
  end
end
