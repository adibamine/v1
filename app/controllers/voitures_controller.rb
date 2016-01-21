class VoituresController < ApplicationController
before_action :set_voiture, only: [:show, :edit, :update]
before_action :authenticate_user!, except: [:show]

def index
  @voitures = current_user.voitures
end

def show
  @photos = @voiture.photos

  @booked = Reservation.where("voiture_id = ? AND user_id = ?", @voiture.id, current_user.id).present? if current_user

  @reviews = @voiture.reviews
  @hasReview = @reviews.find_by(user_id: current_user.id) if current_user
end

def new
  @voiture = current_user.voitures.build
end

def create
  @voiture = current_user.voitures.build(voiture_params)
  if @voiture.save
    if params[:images]
      params[:images].each do |image|
        @voiture.photos.create(image: image)
      end
    end

    @photos = @voiture.photos
    redirect_to edit_voiture_path(@voiture), notice: "Saved.."
  else
    flash[:alert] = "Please provide all information for this car."
    render :new
  end
end

def edit
  if current_user.id == @voiture.user.id
   @photos = @voiture.photos
  else
    redirect_to root_path, notice: "you don't have permission." 
  end
end


def update
  if @voiture.update(voiture_params)

    if params[:images]
      params[:images].each do |image|
        @voiture.photos.create(image: image)
      end
    end

    redirect_to edit_voiture_path(@voiture), notice: "Saved.."
  else
    render :edit
  end
end

private

  def set_voiture
    @voiture = Voiture.find(params[:id])
  end

  def voiture_params
    params.require(:voiture).permit(:annee, :marque, :modele, :kilometrage, :boite_vitesse, :energie, :consommation, :description, :ville, :prix, :active, :is_clim, :is_direction_assiste, :is_regulateur_vitesse, :is_gps, :is_lecteur_cd, :is_audio_input, :nb_places, :nb_portes)
  end
end