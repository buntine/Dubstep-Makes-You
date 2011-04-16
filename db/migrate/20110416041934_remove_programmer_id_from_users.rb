class RemoveProgrammerIdFromUsers < ActiveRecord::Migration
  def self.up
    remove_column :users, :programmer_id
  end

  def self.down
    add_column :users, :programmer_id
  end
end
