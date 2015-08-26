class SubscriptionsController < ApplicationController
  def index
  end

  def create
    @subscription = Subscription.new(email: params[:email])
    if @subscription.save
      render json: { email: params[:email] }, status: :created
    else
      render nothing: true, status: :unprocessable_entity
    end
  end

  def activate
    @subscription = Subscription.find_by_token(params[:token])
    if @subscription
      @subscription.activate
      render json: { message: "Your account has been activated." }
    else
      render json: { message: "Your token has expired." }, status: :not_found
    end
  end
end
