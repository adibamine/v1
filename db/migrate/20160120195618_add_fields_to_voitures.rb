class AddFieldsToVoitures < ActiveRecord::Migration
  def change
    add_column :voitures, :nb_places, :integer
    add_column :voitures, :nb_portes, :integer
  end
end
