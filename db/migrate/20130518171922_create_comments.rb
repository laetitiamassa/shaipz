class CreateComments < ActiveRecord::Migration
  def self.up

    drop_table :comments if Comment.table_exists?

    create_table :comments do |t|
      t.opinio
      t.timestamps
    end
  end

  def self.down
    drop_table :comments
  end
end