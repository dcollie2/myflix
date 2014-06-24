require 'rails_helper'

RSpec.describe UsersController, :type => :controller do
  describe "GET new" do
    it "sets @user" do
      get :new
      expect(assigns(:user)).to be_instance_of(User)
    end
  end
  
  describe "POST create" do
    context "with valid input" do
      
      before { create_valid_user }
      
      it "creates the user" do
        expect(User.count).to eq(1)
      end
      it "redirects to sign-in page" do
        expect(response).to redirect_to sign_in_path
      end
    end
    context "with invalid input" do
      
      before { create_invalid_user }
      
      it "does not create the user" do
        expect(User.count).to eq(0)        
      end
      it "renders the :new template" do
        expect(response).to render_template :new
      end
      it "sets @user" do
        expect(assigns(:user)).to be_instance_of(User)
      end
    end
  end

  def create_valid_user
    post :create, user: Fabricate.attributes_for(:user)
  end
  def create_invalid_user
    post :create, user: { password: "password", full_name: "Full Name" }
  end
end
