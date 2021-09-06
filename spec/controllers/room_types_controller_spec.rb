require "rails_helper"

RSpec.describe RoomTypesController, type: :controller do
  let(:room_type) {FactoryBot.create :room_type}
  describe "GET /show" do
    context "when room type exist" do
      it "should redirect to room type page" do
        get :show, params: {id: room_type.id}
        expect(assigns(:room_type)).to eq(room_type)
      end
    end

    context "when room type not exist" do
      before {get :show, params: {id: 0}}
      it "should flash warning" do
        expect(flash[:warning]).to eq I18n.t("room_types.show.not_found")
      end

      it "should redirect to root path" do
        expect(response).to redirect_to root_path
      end
    end
  end
end
