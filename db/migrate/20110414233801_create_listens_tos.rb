class CreateListensTos < ActiveRecord::Migration
  def self.up
    create_table :listens_tos do |t|
      t.integer :user_id
      t.string :user_type
      t.integer :genre_id

      t.timestamps
    end
  end

  def self.down
    drop_table :listens_tos
  end
end
