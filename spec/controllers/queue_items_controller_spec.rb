require 'rails_helper'

describe QueueItemsController do
  describe "GET index" do
    it "sets @queue_items to the queue items of the logged-in user" do
      fred = Fabricate(:user)
      session[:user_id] = fred.id
      queue_item_1 = Fabricate(:queue_item, user: fred)
      queue_item_2 = Fabricate(:queue_item, user: fred)
      get :index
      expect(assigns(:queue_items)).to match_array([queue_item_1, queue_item_2])
    end
    
    it "redirects to the sign-in page for unauthenticated users" do
      get :index
      expect(response).to redirect_to sign_in_path
    end
    
  end
  
  describe "POST create" do
    context "when logged-in" do
      let(:current_user) { Fabricate(:user) }
      before do
        session[:user_id] = current_user.id 
        @video = Fabricate(:video)
      end
      it "redirects to my_queue" do
        post :create, video_id: @video.id
        expect(response).to redirect_to my_queue_path
      end
      it "creates a queue item" do
        post :create, video_id: @video.id
        expect(QueueItem.count).to eq(1)
      end
      it "creates the queue item associated with the video" do
        post :create, video_id: @video.id
        expect(QueueItem.first.video).to eq(@video)
      end
      it "creates the queue item associated with the signed-in user" do
        post :create, video_id: @video.id
        expect(QueueItem.first.user).to eq(current_user)
      end
      it "should be the last item in the queue" do
        first_video = Fabricate(:video)
        Fabricate(:queue_item, video: first_video, user: current_user)
        post :create, video_id: @video.id
        just_posted_queue_item = QueueItem.where(video_id: @video.id, user_id: current_user.id).first
        expect(just_posted_queue_item.position).to eq(2)
      end
      it "does not add the video if it's already in the queue" do
        Fabricate(:queue_item, video: @video, user: current_user)
        post :create, video_id: @video.id
        video_survey = QueueItem.where(video_id: @video.id, user_id: current_user.id)
        expect(video_survey.count).to eq(1)
      end
      
    end
    context "when not logged-in" do
      it "redirects to the sign-in page for unauthenticated users" do
        video = Fabricate(:video)
        post :create, video_id: video.id
        expect(response).to redirect_to sign_in_path
      end
    end
  end
  
  describe "DELETE destroy" do
    context "when logged-in" do
      let(:current_user) { Fabricate(:user) }
      before do
        session[:user_id] = current_user.id 
      end
      it "redirects to my queue" do
        @queue_item = Fabricate(:queue_item, user: current_user)
        delete :destroy, id: @queue_item.id
        expect(response).to redirect_to my_queue_path
      end
      it "deletes the queue item" do
        @queue_item = Fabricate(:queue_item, user: current_user)
        delete :destroy, id: @queue_item.id
        expect(QueueItem.count).to eq(0)
      end
      it "does not delete item if it is not in the queue" do
        another_user = Fabricate(:user, email: "test@yourmomma.com")
        @queue_item = Fabricate(:queue_item, user: another_user)
        delete :destroy, id: @queue_item.id
        expect(QueueItem.count).to eq(1)
      end
      it 'normalizes the remaining queue items' do
        queue_item_1 = Fabricate(:queue_item, user: current_user, position: 1)
        queue_item_2 = Fabricate(:queue_item, user: current_user, position: 2)
        delete :destroy, id: queue_item_1.id
        expect(QueueItem.first.position).to eq(1)
      end
    end
    context 'when not logged-in' do
      it "redirects to the sign-in page for unauthenticated users" do
        delete :destroy, id: 4        
        expect(response).to redirect_to sign_in_path
      end
    end
  end
  describe 'POST update_queue' do
    context 'with valid inputs' do
      let(:fred) { Fabricate(:user) }
      let(:video) { Fabricate(:video) }
      let(:queue_item_1) { Fabricate(:queue_item, user: fred, video: video, position: 1) }
      let(:queue_item_2) { Fabricate(:queue_item, user: fred, video: video, position: 2) }
      before { session[:user_id] = fred.id }
      it 'redirects to my_queue page' do
        post :update_queue, queue_items: [{id: queue_item_1.id, position: 2},{id: queue_item_2.id, position: 1}]
        expect(response).to redirect_to my_queue_path
      end
      it 'reorders the queue items' do
        post :update_queue, queue_items: [{id: queue_item_1.id, position: 2},{id: queue_item_2.id, position: 1}]
        expect(fred.queue_items).to eq([queue_item_2, queue_item_1])

      end
      it 'normalizes the position numbers' do
        post :update_queue, queue_items: [{id: queue_item_1.id, position: 3},{id: queue_item_2.id, position: 1}]
        expect(fred.queue_items.map(&:position)).to eq([1, 2])
      end

    end
    context 'with invalid inputs' do
      let(:fred) { Fabricate(:user) }
      before { session[:user_id] = fred.id }
      let(:video) { Fabricate(:video) }
      let(:queue_item_1) { Fabricate(:queue_item, user: fred, video: video, position: 1) }
      let(:queue_item_2) { Fabricate(:queue_item, user: fred, video: video, position: 2) }
      it 'redirects to the my queue page' do
        post :update_queue, queue_items: [{id: queue_item_1.id, position: 2.8},{id: queue_item_2.id, position: 1}]
        expect(response).to redirect_to my_queue_path
      end
      it 'sets the flash error message' do
        post :update_queue, queue_items: [{id: queue_item_1.id, position: 2.8},{id: queue_item_2.id, position: 1}]
        expect(flash[:error]).to be_present
      end
      it 'does not change the queue items' do
        post :update_queue, queue_items: [{id: queue_item_1.id, position: 2},{id: queue_item_2.id, position: 1.3}]
        expect(queue_item_1.reload.position).to eq(1)
      end
    end
    context 'with unauthenticated users' do
      it 'redirects to index' do
        post :update_queue, queue_items: [{id: 1, position: 2},{id: 2, position: 1}]
        expect(response).to redirect_to sign_in_path
      end
    end
    context 'with queue items that do not belong to current queue' do
      it 'does not change the queue items' do
        fred = Fabricate(:user)
        session[:user_id] = fred.id
        bob = Fabricate(:user)
        video = Fabricate(:video)
        queue_item_1 = Fabricate(:queue_item, user: fred, video: video, position: 1)
        queue_item_2 = Fabricate(:queue_item, user: bob, video: video, position: 2)
        post :update_queue, queue_items: [{id: queue_item_1.id, position: 2},{id: queue_item_2.id, position: 1.3}]
        expect(queue_item_1.reload.position).to eq(1)
      end
    end

  end
end