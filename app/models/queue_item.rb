class QueueItem < ActiveRecord::Base
  belongs_to :user
  belongs_to :video
  delegate :title, to: :video, prefix: true
  delegate :category, to: :video
  validates_numericality_of :position, {only_integer: true}

  def category_label
    category.label
  end
  
  def rating
    review = Review.where(user_id: user.id, video_id: video.id).first
    review.rating if review
  end

end