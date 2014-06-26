require 'rails_helper'

describe Video do  
  describe "related reviews" do
    it "should calculate a review average" do
      futurama = Fabricate(:video)
      reviews = Fabricate.times(4, :review, video: futurama)
      expect(futurama.average_rating).not_to be_nil
    end
    
    it "average rating should be 0 if there are no reviews" do
      futurama = Fabricate(:video)
      expect(futurama.average_rating).to eq(0)
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
