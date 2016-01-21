class PagesController < ApplicationController
  def home
  	@voitures = Voiture.limit(3)
  end

  def search
  	
  	if params[:search].present? && params[:search].strip != ""
  		session[:loc_search] = params[:search]
  	end

  	arrResult = Array.new

  	if session[:loc_search] && session[:loc_search] != ""
  		@voitures_ville = Voiture.where(active: true, ville: session[:loc_search])
  	else
  		@voitures_ville = Voiture.where(active: true).all
  	end

  	@search = @voitures_ville.ransack(params[:q])
  	@voitures = @search.result

  	@arrVoitures = @voitures.to_a

  	if (params[:start_date] && params[:end_date] && !params[:start_date].empty? & !params[:end_date].empty?)

  		start_date = Date.parse(params[:start_date])
  		end_date = Date.parse(params[:end_date])

  		@voitures.each do |voiture|

  			not_available = voiture.reservations.where(
  					"(? <= start_date AND start_date <= ?)
  					OR (? <= end_date AND end_date <= ?) 
  					OR (start_date < ? AND ? < end_date)",
  					start_date, end_date,
  					start_date, end_date,
  					start_date, end_date
  				).limit(1)

  			if not_available.length > 0
  				@arrVoitures.delete(voiture)	
  			end	

  		end

  	end

  end
end
