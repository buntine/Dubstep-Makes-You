class ListensTo < ActiveRecord::Base
  belongs_to :user
  belongs_to :genre
end
