require "rails_helper"

RSpec.describe PaymentsController, type: :controller do
  let(:current_user) {FactoryBot.create :user}
  let(:room) {FactoryBot.create :room}
  let(:booking) {FactoryBot.create :booking, user: current_user, room: room}

  describe "user access to page" do
    before {sign_in current_user}

    describe "#new" do
      context "go to payments/new failed" do
        before do
          get :new
        end

        it "returns a 302 response" do
          expect(response.response_code).to eq 302
        end

        it "flash return a message error" do
          expect(flash[:danger]).to eq I18n.t("payments.new.no_booking_to_checkout")
        end

        it  "redirects  to  the user  page" do
          expect(response).to redirect_to current_user
        end
      end

      context "go to payments/new success" do
        before do
          current_user.bookings.push(booking)
          current_user.bookings.non_checkout.update_all(is_checkout: false)
        end

        it "return a 200 response" do
          expect(response.response_code).to eq 200
        end
      end
    end

    describe "#create" do
      context "when params valid " do
        before do
          post :create, params: {payment: {amount: 100.0, user_id: current_user.id}}
         end

        it "should flash success" do
          expect(flash[:success]).to eq I18n.t("payments.create.success")
        end

        it "should redirect to current_user" do
          expect(response).to redirect_to current_user
        end
      end

      context "when params invalid " do
        before do
          post :create, params: {payment: {user_id: current_user.id}}
         end

        it "should flash danger" do
          expect(flash[:danger]).to eq I18n.t("payments.create.fail")
        end

        it "should render new" do
          expect(response).to render_template :new
        end
      end
    end
  end
end
