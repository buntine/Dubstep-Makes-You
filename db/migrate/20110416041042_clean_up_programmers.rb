class CleanUpProgrammers < ActiveRecord::Migration
  def self.up
    remove_column :programmers, :lastfm_username
    remove_column :programmers, :terms
    remove_column :programmers, :terms_last_updated
  end

  def self.down
    add_column :programmers, :lastfm_username
    add_column :programmers, :terms
    add_column :programmers, :terms_last_updated
  end
end
