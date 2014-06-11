class Category < ActiveRecord::Base
  has_many :videos, -> { order("created_at DESC") }
  validates_presence_of :label
  
  def recent_videos
    videos.first(6)
  end
  
  def has_no_videos?
    videos.count < 1
  end
end
