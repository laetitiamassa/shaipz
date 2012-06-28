class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.references :owner, :null => false
      t.string :name, :null => false
      t.string :address
      t.integer :total_amount, :null => false
      t.integer :total_space, :null => false
      t.integer :maximum_shaipz, :null => false
      t.string :source_link
      t.boolean :cohousing, :default => false
      t.text :event
      t.has_attached_file :picture
      t.timestamps
    end
  end
end
