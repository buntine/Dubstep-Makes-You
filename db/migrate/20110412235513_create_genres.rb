class CreateGenres < ActiveRecord::Migration
  def self.up
    create_table :genres do |t|
      t.string :name
      t.integer :parent_id
      t.integer :left
      t.integer :right

      t.timestamps
    end
  end

  def self.down
    drop_table :genres
  end
end
