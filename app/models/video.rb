class Video < ActiveRecord::Base
  belongs_to :category
  delegate :label, to: :category, prefix: true
  validates_presence_of :title, :description
  
  def self.search_by_title(search_term)
    return [] if search_term.blank?
    where('title like ?', "%#{search_term}%").order("created_at DESC")
  end
end
