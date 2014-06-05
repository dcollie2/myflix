class Video < ActiveRecord::Base
  belongs_to :category
  delegate :label, to: :category, prefix: true
end
