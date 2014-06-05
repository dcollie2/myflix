class Category < ActiveRecord::Base
  has_many :videos
  
  def has_no_videos?
    videos.count < 1
  end
end
