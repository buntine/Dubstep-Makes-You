class AddAttributesToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :dribbble_username, :string
    add_column :users, :lastfm_username, :string
    add_column :users, :github_username, :string
  end

  def self.down
    remove_column :users, :github_username
    remove_column :users, :lastfm_username
    remove_column :users, :dribbble_username
  end
end
