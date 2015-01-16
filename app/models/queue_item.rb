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
    review.rating if review
  end

  def rating=(new_rating)
    if review
      review.update_column(:rating, new_rating)
    else
      review = Review.new(user: user, rating: new_rating, video: video)
      review.save(validate: false)
    end
  end

  private

  def review
    @review ||= Review.where(user_id: user.id, video_id: video.id).first
  end

end