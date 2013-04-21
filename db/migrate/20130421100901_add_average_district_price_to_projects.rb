class AddAverageDistrictPriceToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :average_district_price, :integer
  end
end
