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
end