class Programmer < ActiveRecord::Base
  validates :github_username, :presence => true, :uniqueness => true
  belongs_to :user
  attr_reader :account
  
  before_save :get_skill
  
  def account
    @account ||= DubstepMakesYou::GitHub.new github_username
  end
  
  protected

  def get_skill
    self.skill = (account.popularity / account.days_since_last_commit).round
  end
  
end