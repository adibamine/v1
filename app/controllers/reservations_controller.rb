class ReservationsController < ApplicationController
	before_action :authenticate_user!
	
	def preload
		voiture = Voiture.find(params[:voiture_id])
		today = Date.today
		reservations = voiture.reservations.where("start_date >= ? OR end_date >= ?", today, today)

		render json: reservations
	end

	def preview
		start_date = Date.parse(params[:start_date])
		end_date = Date.parse(params[:end_date])

		output = {
			conflict: is_conflict(start_date, end_date)
		}

		render json:output
	end


	def create
		@reservation = current_user.reservations.create(reservation_params)

		redirect_to @reservation.voiture, notice: "Votre reservation a bien ete cree"
	end

	def vos_locations
		@locations = current_user.reservations
	end

	def vos_reservations
		@voitures = current_user.voitures
	end

	private
		def is_conflict(start_date, end_date)
			voiture = Voiture.find(params[:voiture_id])

			check = voiture.reservations.where("? < start_date AND end_date < ?", start_date, end_date)
			check.size > 0? true : false
		end


		def reservation_params
			params.require(:reservation).permit(:start_date, :end_date, :prix, :total, :voiture_id)
		end


end