class Video < ActiveRecord::Base
  belongs_to :category
  has_many :reviews, -> { order("created_at DESC") }
  delegate :label, to: :category, prefix: true
  
  validates_presence_of :title, :description
  
  def average_rating
    ratings = reviews.map { |review| review.rating }
    (ratings.sum / ratings.count.to_f).round rescue 0
  end
    
  def self.search_by_title(search_term)
    return [] if search_term.blank?
    where('title like ?', "%#{search_term}%").order("created_at DESC")
  end
end
