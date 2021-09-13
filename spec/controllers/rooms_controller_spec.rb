require "rails_helper"

RSpec.describe RoomsController, type: :controller do
  let(:room_type) {FactoryBot.create :room_type}
  let(:room) {FactoryBot.create :room, room_type_id: room_type.id}
  describe "GET /show" do
    context "when room exist" do
      it "should redirect to room page" do
        get :show, params: {id: room.slug}, xhr: true
        expect(response.content_type).to eq "text/javascript; charset=utf-8"
      end
    end

    context "when room not exist" do
      before {get :show, params: {id: 0}}
      it "should flash warning" do
        expect(flash[:warning]).to eq I18n.t("rooms.show.not_found")
      end

      it "should redirect to root path" do
        expect(response).to redirect_to root_path
      end
    end
  end
end
