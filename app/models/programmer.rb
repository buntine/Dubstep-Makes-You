class Programmer < ActiveRecord::Base
  validates :github_username, :presence => true, :uniqueness => true
  validates :lastfm_username, :presence => true, :uniqueness => true
end
