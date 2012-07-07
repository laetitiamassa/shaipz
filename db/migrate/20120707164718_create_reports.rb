class CreateReports < ActiveRecord::Migration
  def self.up
    create_table :reports do |t|
      t.references :reportable, :polymorphic => true, :null => false
      t.text :content, :null => false
      t.references :reporter, :null => false
      t.timestamps
    end
    add_index :reports, [:reportable_id, :reportable_type]
  end

  def self.down
    drop_table :reports
  end
end
