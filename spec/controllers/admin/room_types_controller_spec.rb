require "rails_helper"
include SessionsHelper

RSpec.describe Admin::RoomTypesController, type: :controller do
  let(:room_type) {FactoryBot.create :room_type}
  let(:admin) {FactoryBot.create :user, role: User.roles[:admin]}
  before {log_in admin}

  describe "GET /new" do
    before {get :new}
    it "should create new room type" do
      expect(assigns(:room_type)).to be_a_new RoomType
    end

    it "should render template new" do
      expect(response).to render_template :new
    end
  end

  describe "GET /show" do
    it "should render template 'room_types/show'" do
      get :show, params: {id: room_type.id}
      expect(response).to render_template "room_types/show"
    end
  end

  describe "#load_room_type" do
    context "when room type exist" do
      it "should redirect to room type page" do
        get :show, params: {id: room_type.id}
        expect(assigns(:room_type)).to eq(room_type)
      end
    end

    context "when room type not exist" do
      before {get :show, params: {id: 0}}
      it "should flash danger" do
        expect(flash[:danger]).to eq I18n.t("admin.room_types.not_found")
      end

      it "should redirect to root path" do
        expect(response).to redirect_to admin_path
      end
    end
  end

  describe "POST /create" do
    context "when params is valid" do
      before do
        post :create, params: {room_type: FactoryBot.attributes_for(:room_type)}
      end

      it "should create new room type" do
        expect(assigns(:room_type)).to be_a RoomType
      end

      it "should flash success" do
        expect(flash[:success]).to eq I18n.t("admin.room_types.create.success")
      end

      it "should redirect to new room type" do
        new_room_type = assigns(:room_type)
        expect(response).to redirect_to new_room_type
      end
    end

    context "when params is invalid" do
      before {post :create, params: {room_type: {cost: 100}}}
      it "should flash danger" do
        expect(flash[:danger]).to eq I18n.t("admin.room_types.create.fail")
      end

      it "should render_template new" do
        expect(response).to render_template :new
      end
    end
  end

  describe "PATCH /update" do
    context "when update params is valid" do
      before do
        post :update, params: {id: room_type.id, room_type: {cost: 100}}
      end

      it "should flash success" do
        expect(flash[:success]).to eq I18n.t("admin.room_types.update.success")
      end

      it "should redirect to updated room type" do
        updated_room_type = assigns(:room_type)
        expect(response).to redirect_to updated_room_type
      end
    end

    context "when update params is invalid" do
      before do
        post :update, params: {id: room_type.id, room_type: {cost: "abc"}}
      end

      it "should flash danger" do
        expect(flash[:danger]).to eq I18n.t("admin.room_types.update.fail")
      end

      it "should render template edit" do
        expect(response).to render_template :edit
      end
    end
  end

  describe "DELETE /detroy" do
    context "when delete valid room type" do
      before do
        delete :destroy, params: {id: room_type.id}
      end

      it "should flash success" do
        expect(flash[:success]).to eq I18n.t("admin.room_types.destroy.success")
      end

      it "should redirect to admin path" do
        expect(response).to redirect_to admin_path
      end
    end

    context "when delete invalid room type" do
      before do
        allow_any_instance_of(RoomType).to receive(:destroy).and_return(false)
        delete :destroy, params: {id: room_type.id}
      end

      it "should flash danger" do
        expect(flash[:danger]).to eq I18n.t("admin.room_types.destroy.fail")
      end

      it "should redirect to admin path" do
        expect(response).to redirect_to admin_path
      end
    end
  end
end
