class Admin::PaymentsController < AdminController
  def index
    @payments = Payment.order(:is_paid).all.page params[:page]
  end

  def change_paid_status
    @payment = Payment.find_by id: params[:id]
    if @payment
      @payment.update("is_paid": true, "payment_date": Time.zone.now)
      flash[:success] = t ".success"
    else
      flash[:danger] = t ".not_found"
    end
    redirect_to admin_payments_path
  end
end
