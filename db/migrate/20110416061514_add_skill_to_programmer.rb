class AddSkillToProgrammer < ActiveRecord::Migration
  def self.up
    add_column :programmers, :skill, :integer
  end

  def self.down
    remove_column :programmers, :skill
  end
end
