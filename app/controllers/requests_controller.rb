class RequestsController < ApplicationController

  def new
    @request = Request.new
  end

  def create
    @request = Request.new(request_params)

    if @request.save
      redirect_to new_request_path, notice: 'Go check your emails and click on the link to confirm it'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def confirm_email
    Request.find(params[:request]).update_attribute(:email_confirmation, true)
    redirect_to new_request_path, notice: 'Your email has been confirmed'
  end

  private

  def request_params
    params.require(:request).permit(:name, :email, :phone_number, :biography)
  end
end
