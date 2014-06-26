class ReviewsController < ApplicationController
  before_filter :require_user
  
  def create
    @video = Video.find(params[:video_id])
    review = @video.reviews.build(permitted_params.merge!(user: current_user))
    if review.save
      flash[:message] = "Thank you for your review."
      redirect_to @video
    else
      @reviews = @video.reviews.reload
      flash[:error] = "Please provide both a rating and a review."
      render 'videos/show'
    end
  end
  
  private
  
  def permitted_params
    params.require(:review).permit(:content, :rating)
  end
    
end