class Category < ActiveRecord::Base
  has_many :videos, -> { order(:title) }
  validates_presence_of :label
  
  def has_no_videos?
    videos.count < 1
  end
end
