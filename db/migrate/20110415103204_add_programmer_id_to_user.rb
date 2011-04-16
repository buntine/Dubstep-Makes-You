class AddProgrammerIdToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :programmer_id, :integer
  end

  def self.down
    remove_column :users, :programmer_id
  end
end
