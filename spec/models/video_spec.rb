require 'rails_helper'

RSpec.describe Video, :type => :model do
  it "saves itself" do
    video = Video.new(title: "Shakes the Clown", description: "The horror. The horror.")
    video.save
    expect(Video.first).to eq(video)
  end
end
