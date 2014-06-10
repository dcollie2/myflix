require 'rails_helper'

# Comment added to test github flow
RSpec.describe Category, :type => :model do
  it { should have_many(:videos)}
  it { should validate_presence_of(:label)}  
end
