class SubscriptionsController < ApplicationController
  def index
  end

  def create
    @subscription = Subscription.new(email: params[:email])
    if @subscription.save
      Mailer.activate(@subscription)
      render json: { email: params[:email] }, status: :created
    else
      render nothing: true, status: :unprocessable_entity
    end
  end

  def activate
    @subscription = Subscription.find_by_token(params[:token])
    @presenter    = SubscriptionPresenter.new(@subscription)
    @subscription.activate if @subscription
  end
end
