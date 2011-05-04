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
    self.descendents.inject(self.programming_skill) do |total, g|
      total + g.programming_skill
    end
  end
  
  def programming_skill
    self.users.inject(0) do |total, u|
      u.is_programmer? ? (total + u.programmer.skill) : total
    end
  end
end