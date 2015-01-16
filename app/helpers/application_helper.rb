module ApplicationHelper
  def options_for_video_reviews(selected=nil)
    options_for_select([1,2,3,4,5].map { |number| [pluralize(number, "Star"), number] }, selected)
  end
end
