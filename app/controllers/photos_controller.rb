class PhotosController < ApplicationController

	def destroy
		@photo = Photo.find(params[:id])
		voiture = @photo.voiture

		@photo.destroy
		@photos = Photo.where(voiture_id: voiture.id)

		respond_to :js
	end

end