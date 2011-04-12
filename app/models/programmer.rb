class Programmer < ActiveRecord::Base
  validates :github_username, :presence => true, :uniqueness => true
  validates :lastfm_username, :presence => true, :uniqueness => true
  
  attr_reader :github,
              :lastfm
  
  def github
    @github ||= Octopi::User.search(github_username).first
  end
  
  def lastfm
    @lastfm ||= DubstepMakesYou::LastFM.new(lastfm_username)
  end
  
  def listens_to?(genre)
    lastfm.genres.collect{ |t| t['name'] }.include? genre
  end
  
  def method_missing(method_sym, *arguments, &block)
    if method_sym.to_s =~ /^listens_to_(.*)?\?$/
      listens_to? parse_genre($1)
    else
      super
    end
  end
  
  def popularity
    github.followers.length + github.repos
  end
  
  def skill
    (popularity / days_since_last_commit).round
  end
  
  def seconds_since_last_commit
    last_push = Time.parse github.pushed
    now       = Time.now
    (now - last_push).round
  end
  
  def minutes_since_last_commit
    (seconds_since_last_commit / 60).round
  end
  
  def hours_since_last_commit
    (minutes_since_last_commit / 60).round
  end
  
  def days_since_last_commit
    (hours_since_last_commit / 24).round
  end
  
  private
  
  def parse_genre(genre)
    genre.gsub('_',' ').downcase
  end
end