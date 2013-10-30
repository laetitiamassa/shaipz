class CreateCondos < ActiveRecord::Migration
  def change
    create_table :condos do |t|

      t.timestamps
    end
  end
end
