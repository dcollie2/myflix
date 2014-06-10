class Video < ActiveRecord::Base
  belongs_to :category
  delegate :label, to: :category, prefix: true
  validates_presence_of :title, :description
end
