class AddFieldsToVoiture < ActiveRecord::Migration
  def change
    add_column :voitures, :is_clim, :boolean
    add_column :voitures, :is_direction_assiste, :boolean
    add_column :voitures, :is_regulateur_vitesse, :boolean
    add_column :voitures, :is_gps, :boolean
    add_column :voitures, :is_lecteur_cd, :boolean
    add_column :voitures, :is_audio_input, :boolean
    rename_column :voitures, :adresse, :ville
  end
end
