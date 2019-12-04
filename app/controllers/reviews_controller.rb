class ReviewsController < ApplicationController
  def new
    @shelter = Shelter.find(params[:shelter_id])
  end

  def create
    @shelter = Shelter.find(params[:shelter_id])
    review = Review.new(review_params.merge(shelter_id: @shelter.id))
    if review.save
      redirect_to "/shelters/#{@shelter.id}"
    else
      flash[:error] = review.errors.full_messages.to_sentence
      render :new
    end
  end

  def edit
    @review = Review.find(params[:review_id])
  end

  private

  def review_params
    params.permit(:title, :rating, :content, :image)
  end
end
