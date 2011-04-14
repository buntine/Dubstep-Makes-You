class ListensTo < ActiveRecord::Base
  belongs_to :user, :polymorphic => true
  belongs_to :genre
end
