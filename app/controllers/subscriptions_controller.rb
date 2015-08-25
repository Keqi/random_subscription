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
end
