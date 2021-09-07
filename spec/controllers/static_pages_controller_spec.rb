require "rails_helper"
include SessionsHelper

RSpec.describe StaticPagesController, type: :controller do
  let(:user) {FactoryBot.create :user}

  describe "GET /home" do
    it "should render home page" do
      get :home, params: {q: "Single"}
      expect(response).to render_template "static_pages/home"
    end
  end

  describe "GET /booking" do
    before {log_in user}
    it "should render booking_path" do
      10.times do
        FactoryBot.create :room_type
      end
      get :user_booking, params: {q: "Single"}
      expect(response).to render_template "static_pages/user_booking"
    end
  end
end
