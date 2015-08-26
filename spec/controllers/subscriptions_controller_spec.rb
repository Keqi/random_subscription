require 'rails_helper'

RSpec.describe SubscriptionsController, :type => :controller do
  before do
    stub_request(:post, /https:\/\/api:key-.*@api.mailgun.net\/v3\/.*/).
      with(headers: {'User-Agent'=>'Typhoeus - https://github.com/typhoeus/typhoeus'}).
      to_return(status: 200, body: "", headers: {})
  end

  describe "POST create" do
    it "returns 201 with email when subscription was created" do
      post :create, email: "maciejnowak@gmail.com"

      expect(response.code).to eq("201")
      expect(JSON.parse(response.body)).to eq({ "email" => "maciejnowak@gmail.com" })
    end

    it "returns 422 with no content when record could not be saved" do
      post :create, email: "maciejnowak.gmail.com"

      expect(response.code).to eq("422")
      expect(response.body).to be_empty
    end
  end

  describe "GET activate" do
    it "activates account if subscription with given token was found" do
      subscription = Subscription.create!(email: "maciejnowak@gmail.com")

      get :activate, token: subscription.token

      expect(response.status).to eq(200)
      expect(subscription.reload.token).to be_nil
    end

    it "returns 200 with subscription not activated" do
      subscription = Subscription.create!(email: "maciejnowak@gmail.com")

      get :activate, token: "abcd1234"

      expect(response.status).to eq(200)
      expect(subscription.reload.token).not_to be_nil
    end
  end
end
