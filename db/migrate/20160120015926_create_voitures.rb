class CreateVoitures < ActiveRecord::Migration
  def change
    create_table :voitures do |t|
      t.string :annee
      t.string :marque
      t.string :modele
      t.string :kilometrage
      t.string :boite_vitesse
      t.string :energie
      t.integer :consommation
      t.text :description
      t.string :adresse
      t.integer :prix
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
