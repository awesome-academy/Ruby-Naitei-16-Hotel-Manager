class PaymentsController < ApplicationController
  before_action :authenticate_user!, only: %i(new create)

  def new
    @payment = Payment.new
    @non_checkout_bookings = current_user.bookings.non_checkout
    return if @non_checkout_bookings.present?

    flash[:danger] = t ".no_booking_to_checkout"
    redirect_to book_user_path(current_user)
  end

  def create
    @payment = current_user.payments.new payment_params
    if @payment.save
      flash[:success] = t ".success"
      redirect_to payment_user_path(current_user)
    else
      flash[:danger] = t ".fail"
      render :new
    end
  end

  def show; end

  private

  def payment_params
    params.require(:payment).permit Payment::PERMITTED
  end
end
