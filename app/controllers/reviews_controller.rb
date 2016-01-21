class ReviewsController < ApplicationController

	def create
		@review = current_user.reviews.create(review_params)
		redirect_to @review.voiture
	end

	def destroy
		@review = Review.find(params[:id])
		voiture = @review.voiture
		@review.destroy

		redirect_to voiture
	end

	private
		def review_params
			params.require(:review).permit(:comment, :star, :voiture_id)
		end
end