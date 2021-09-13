require "rails_helper"

RSpec.describe UsersController, type: :controller do
  let(:user){FactoryBot.create :user}
  before {sign_in user}

  describe "GET /new" do
    before {get :new}
    it "should create new user" do
      expect(assigns(:user)).to be_a_new User
    end

    it "should render template new" do
      expect(response).to render_template :new
    end
  end

  describe "GET /show" do
    it "should render template show" do
      get :show, params: {id: user.slug, q: {s: "created_at"}}
      expect(response).to render_template "users/show"
    end
  end

  describe "POST /create" do
    context "when params is valid" do
      before do
        post :create, params: {user: FactoryBot.attributes_for(:user)}
      end

      it "should redirect to login path" do
        expect(response).to redirect_to new_user_session_path
      end
    end

    context "when params is invalid" do
      before {post :create, params: {user: {name: "abc"}}}

      it "should render_template new" do
        expect(response).to render_template :new
      end
    end
  end

  describe "PATCH /update" do
    context "when update params is valid" do
      before do
        post :update, params: {id: user.slug, user: {gender: "male"}}
      end

      it "should redirect to updated user" do
        expect(response).to redirect_to assigns(:user)
      end
    end

    context "when update params is invalid" do
      before do
        post :update, params: {id: user.slug, user: {email: "abc"}}
      end

      it "should render template edit" do
        expect(response).to render_template :edit
      end
    end
  end
end
