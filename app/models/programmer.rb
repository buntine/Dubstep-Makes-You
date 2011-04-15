class Programmer < ActiveRecord::Base
  validates :github_username, :presence => true, :uniqueness => true
  validates :lastfm_username, :presence => true, :uniqueness => true
  
  has_many :listens_to, :as => :user
  has_many :genres, :through => :listens_to
  
  attr_reader :github, :lastfm  
  
  before_save :build_listens_to
  
  def github
    @github ||= DubstepMakesYou::GitHub.new(github_username)
  end
  
  def lastfm
    @lastfm ||= DubstepMakesYou::LastFM.new(lastfm_username)
  end

  def skill
    (github.popularity / github.days_since_last_commit).round
  end
  
  def listens_to?(genre)
    lastfm.genres.collect{ |t| t['name'] }.include? genre
  end
  
  private
  
  def parse_genre(genre)
    genre.gsub('_',' ').downcase
  end
  
  def build_listens_to
    # build all the listens to
  end
  
end