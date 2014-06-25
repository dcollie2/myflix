require 'rails_helper'

describe Video do
  it { should belong_to(:category)}
  it { should validate_presence_of(:title)}
  it { should validate_presence_of(:description)}  

  describe "related reviews" do
    it "should calculate a review average" do
      futurama = Fabricate(:video)
      reviews = Fabricate.times(4, :review, video: futurama)
      ratings = reviews.map { |review| review.rating }
      average_rating = (ratings.sum / ratings.count).round
      expect(futurama.average_rating).to eq(average_rating)
    end
  end
  
  describe "search_by_title" do
    it "returns an empty array if there is no match" do
      futurama = Video.create(title: "futurama", description: "amazon women in the mood")
      back_to_the_future = Video.create(title: "back to the future", description: "my wife won't watch this")
      expect(Video.search_by_title("Nope")).to eq ([])
    end
    it "returns an array of one video for an exact match" do
      futurama = Video.create(title: "futurama", description: "amazon women in the mood")
      back_to_the_future = Video.create(title: "back to the future", description: "my wife won't watch this")
      expect(Video.search_by_title("futurama")).to eq ([futurama])
    end
    
    it "returns an array of one video for a partial match" do
      futurama = Video.create(title: "futurama", description: "amazon women in the mood")
      back_to_the_future = Video.create(title: "back to the future", description: "my wife won't watch this")
      expect(Video.search_by_title("rama")).to eq ([futurama])
    end
    
    it "returns an array of matches ordered by created_at" do
      futurama = Video.create(title: "futurama", description: "amazon women in the mood")
      back_to_the_future = Video.create(title: "back to the future", description: "my wife won't watch this")
      expect(Video.search_by_title("futur")).to eq ([back_to_the_future, futurama])
    end
    
    it "returns an empty array when search term is an empty string" do
      futurama = Video.create(title: "futurama", description: "amazon women in the mood")
      back_to_the_future = Video.create(title: "back to the future", description: "my wife won't watch this")
      expect(Video.search_by_title("")).to eq ([])
    end
    
  end
end
