class AddHideBudgetToUser < ActiveRecord::Migration
  def change
    add_column :users, :hide_budget, :boolean, :default => false
  end
end
