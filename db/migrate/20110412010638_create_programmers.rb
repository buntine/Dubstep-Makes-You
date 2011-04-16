class CreateProgrammers < ActiveRecord::Migration
  def self.up
    create_table :programmers do |t|
      t.string :github_username
      t.string :lastfm_username
      t.string :terms
      t.date :terms_last_updated

      t.timestamps
    end
  end

  def self.down
    drop_table :programmers
  end
end
