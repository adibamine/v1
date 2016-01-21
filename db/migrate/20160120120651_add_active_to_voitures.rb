class AddActiveToVoitures < ActiveRecord::Migration
  def change
    add_column :voitures, :active, :boolean
  end
end
