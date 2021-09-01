require "rails_helper"
include SessionsHelper

RSpec.describe BookingsController, type: :controller do
  let(:booking){FactoryBot.create :booking}
  let(:current_user){FactoryBot.create :user}
  let(:room){FactoryBot.create :room}
  let(:params){{booking: FactoryBot.attributes_for(:booking)}}
  let(:create_params){{
    booking: {
      total: 1,
      room_type: room.room_type_id,
      checkin: DateTime.now + 1.day,
      checkout: DateTime.now + 2.day
    }
  }}

  before {log_in current_user}

  describe "POST /create" do
    context "when total is not numberic or nil" do
      before do
        create_params[:booking][:total] = "abc"
        post :create, params: create_params
      end

      it "display flash danger" do
        expect(flash[:danger]).to eq I18n.t("bookings.create.fail")
      end

      it "redirect to book_path" do
        expect(response).to redirect_to book_path
      end
    end

    context "when hasn't enough room available" do
      before do
        create_params[:booking][:room_type] = -1
        post :create, params: create_params
      end
      it "display flash danger" do
        expect(flash[:danger]).to eq I18n.t("bookings.create.fail")
      end

      it "redirect to book_path" do
        expect(response).to redirect_to book_path
      end
    end

    context "when booking successfully" do
      before {post :create, params: create_params}

      it "display flash success" do
        expect(flash[:success]).to eq I18n.t("bookings.create.success")
      end

      it "redirect to current_user" do
        expect(response).to redirect_to current_user
      end
    end

    context "when booking fail" do
      before do
        create_params[:booking][:checkin] = DateTime.now - 2.day
        post :create, params: create_params
      end

       it "display flash danger" do
        expect(flash[:danger]).to eq I18n.t("bookings.create.fail")
      end

      it "redirect to book_path" do
        expect(response).to redirect_to book_path
      end
    end
  end

  describe "PATCH /update" do
    let(:current_checkout){booking.checkin}

    context "when booking not found" do
      before{get :show, params: {id: -1}}

      it "display flash danger" do
        expect(flash[:danger]).to eq I18n.t("bookings.errors.not_found")
      end

      it "redirect to current_user" do
        expect(response).to redirect_to current_user
      end
    end

    context "when deadline for update expired" do
      before do
        booking.created_at = DateTime.now - 2.day
        booking.save
        params[:id] = booking.id
        patch :update, params: params
      end

      it "display flash danger" do
        expect(flash[:danger]).to eq I18n.t("bookings.errors.deadline_expired")
      end

      it "redirect to current_user" do
        expect(response).to redirect_to current_user
      end
    end

    context "when update successfully" do
      before do
        params[:id] = booking.id
        params[:booking][:checkout] = DateTime.now + 5.day
        patch :update, params: params
      end

      it "change checkout field" do
        expect(booking.reload.checkout).to_not eq(current_checkout)
      end

      it "display flash success" do
        expect(flash[:success]).to eq I18n.t("bookings.update.booking_updated")
      end

      it "redirect to current_user" do
        expect(response).to redirect_to current_user
      end
    end

    context "when update failed by validation" do
      before do
        params[:id] = booking.id
        params[:booking][:checkout] = booking.checkin - 1.day
        patch :update, params: params, xhr: true
      end

      it "display flash danger" do
        expect(flash[:danger]).to eq I18n.t("bookings.update.update_fail")
      end

      it "render template edit" do
        expect(response).to render_template :edit
      end
    end
  end

  describe "DELETE /destroy" do
    context "deleted successfully" do
      before do
        params[:id] = booking.id
        delete :destroy, params: params, xhr: true
      end

      it "display flash success" do
        expect(flash[:success]).to eq I18n.t("bookings.destroy.booking_deleted")
      end

      it "redirect to current_user" do
        expect(response).to redirect_to current_user
      end
    end

    context "delete fail" do
      before :each do
        allow_any_instance_of(Booking).to receive(:destroy!).and_raise(ActiveRecord::RecordInvalid)
        params[:id] = booking.id
        delete :destroy, params: params
      end
      it "display flash danger" do
        expect(flash[:danger]).to eq I18n.t("bookings.destroy.delete_fail")
      end

      it "redirect to delete" do
        expect(response).to redirect_to current_user
      end
    end
  end
end
