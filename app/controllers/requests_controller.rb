class RequestsController < ApplicationController
  before_action :set_request, only: [:confirm_email, :reconfirm_email]

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
    @request.update(email_confirmation: true, confirmed_at: Date.today)
    redirect_to new_request_path, notice: 'Your email has been confirmed'
  end

  def reconfirm_email
    @request.update(email_confirmation: true, confirmed_at: Date.today)
    redirect_to new_request_path, notice: 'Your email has been reconfirmed'
  end

  private

  def set_request
    @request = Request.find(params[:request])
  end

  def request_params
    params.require(:request).permit(:name, :email, :phone_number, :biography)
  end
end
