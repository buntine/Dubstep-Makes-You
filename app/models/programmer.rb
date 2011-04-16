class Programmer < ActiveRecord::Base
  validates :github_username, :presence => true, :uniqueness => true
  belongs_to :user
  attr_reader :account
  
  def account
    @account ||= DubstepMakesYou::GitHub.new github_username
  end

  def level
    (account.popularity / account.days_since_last_commit).round
  end
  
end