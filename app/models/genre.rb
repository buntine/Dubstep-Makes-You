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
end
