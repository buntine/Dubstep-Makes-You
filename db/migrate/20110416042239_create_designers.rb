class CreateDesigners < ActiveRecord::Migration
  def self.up
    create_table :designers do |t|
      t.string :dribbble_username
      t.integer :user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :designers
  end
end