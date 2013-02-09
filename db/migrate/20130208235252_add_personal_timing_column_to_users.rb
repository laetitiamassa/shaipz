class AddPersonalTimingColumnToUsers < ActiveRecord::Migration
  def change
    add_column :users, :personal_timing, :string
  end
end
