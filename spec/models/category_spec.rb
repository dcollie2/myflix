require 'rails_helper'

describe Category do
  it { should have_many(:videos)}
  it { should validate_presence_of(:label)}
  
  describe "#recent_videos" do
    it "returns videos in reverse chron by created_at" do
      comedies = Category.create(label: "Comedies")
      boondocks = Video.create(title: "Boondocks", description: "That stuff.", category: comedies, created_at: 1.day.ago)
      sherlock = Video.create(title: "Sherlock", description: "Not really a comedy.", category: comedies)
      expect(comedies.recent_videos).to eq ([sherlock, boondocks])
    end
    
    it "returns all videos if there are fewer than six" do
      comedies = Category.create(label: "Comedies")
      boondocks = Video.create(title: "Boondocks", description: "That stuff.", category: comedies)
      sherlock = Video.create(title: "Sherlock", description: "Not really a comedy.", category: comedies)
      expect(comedies.recent_videos.count).to eq 2
    end
    it "returns six videos if there are more than six" do
      comedies = Category.create(label: "Comedies")
      7.times { Video.create(title: "Boondocks", description: "That stuff.", category: comedies) }
      expect(comedies.recent_videos.count).to eq 6
    end
    
    it "returns the most recent six videos" do
      comedies = Category.create(label: "Comedies")
      6.times { Video.create(title: "Boondocks", description: "That stuff.", category: comedies) }
      older_video = Video.create(title: "Boondocks", description: "That stuff.", category: comedies, created_at: 1.day.ago)
      expect(comedies.recent_videos).not_to include(older_video)
    end
    
    it "returns an empty array if the category does not have any videos" do
      comedies = Category.create(label: "Comedies")
      expect(comedies.recent_videos).to eq([])
    end
  end
end