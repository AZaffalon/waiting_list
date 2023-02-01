class RequestsController < ApplicationController

  def new
    @request = Request.new
  end

  def create
    @request = Request.new(request_params)

    if @request.save
      redirect_to new_request_path, notice: 'An email has been sent to your email address'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def confirm_email
    Request.find(params[:request]).update_attribute(:email_confirmation, true)
    redirect_to new_request_path, notice: 'Your email has been confirmed'
  end

  def reconfirm_email
    # TODO
  end

  private

  def request_params
    params.require(:request).permit(:name, :email, :phone_number, :biography)
  end
end
