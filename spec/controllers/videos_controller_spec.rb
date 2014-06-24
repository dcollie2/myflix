require 'rails_helper'

RSpec.describe VideosController, :type => :controller do

  context 'when not logged in' do
    describe "GET index" do
      it "it should redirect" do
        get :index
        expect(response).to redirect_to sign_in_path
      end      
    end
    describe "POST search" do
      it "it should redirect" do
        post :search
        expect(response).to redirect_to sign_in_path
      end      
    end
    describe "GET show" do
      it "it should redirect" do
        video = Fabricate(:video)
        get :show, id: video.id
        expect(response).to redirect_to sign_in_path
      end      
    end
  end
  
  context 'when logged in' do
    before do 
      session[:user_id] = Fabricate(:user).id
    end
    
    describe 'GET index' do

      it 'returns the index template' do
        get :index
        expect(response).to render_template(:index)
      end

      it "sets the @categories variable" do
        categories = Fabricate.times(2, :category)
        get :index
        expect(assigns(:categories).count).to eq(2)
      end
    end
    
    describe "POST search" do
      subject { post :search, {search_term: "test"} }
      it "sets the @results variable" do
        sherlock = Fabricate(:video, title: "Sherlock")
        post :search, search_term: "lock"
        expect(assigns(:results)).to eq([sherlock])
      end
    end
    
    describe "GET show" do
      it "sets @video" do
        video = Fabricate(:video)
        get :show, id: video.id
        expect(assigns(:video)).to eq(video)
      end        
    end

  end
  
end
