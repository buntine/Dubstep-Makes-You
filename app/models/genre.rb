class Genre < ActiveRecord::Base
  validates :name, :presence => true
  
  has_many :listens_to
  has_many :users, :through => :listens_to
  
  acts_as_nested_set
  
  def related
    self.family + self.generation + self.ancestors + self.descendants
  end
  
  def is_related_to?(genre)
    related.collect(&:name).include? genre
  end
  
  def descendant_programming_skill
    total = 0
    self.descendants.each do |genre|
      total += genre.programming_skill
    end
    return total + self.programming_skill
  end
  
  def programming_skill
    total = 0
    self.users.each do |user|
      total += user.programmer.skill if user.is_programmer?
    end
    return total
  end
end
