class Programmer < ActiveRecord::Base
  validates :github_username, :presence => true, :uniqueness => true
  validates :lastfm_username, :presence => true, :uniqueness => true
  
  attr_reader :github
  
  def github
    @github ||= Octopi::User.search(github_username).first
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
end