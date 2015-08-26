require 'rails_helper'

RSpec.describe Mailer, type: :lib do
  let(:recipients) { ["maciejnowak@gmail.com", "robertnowak@gmail.com"] }

  before do
    stub_request(:post, /https:\/\/api:key-.*@api.mailgun.net\/v3\/.*/).
      with(headers: {'User-Agent'=>'Typhoeus - https://github.com/typhoeus/typhoeus'}).
      to_return(status: 200, body: "", headers: {})
  end

  describe "#activate" do
    it "sends activation link in email for given subscription" do
      subscription = Subscription.create!(email: "maciejnowak@gmail.com")

      response = Mailer.activate(subscription)
      params   = response.request.options[:params]

      expect(params[:from]).to eq("subscription@daily-random.com")
      expect(params[:to]).to eq(subscription.email)
      expect(params[:subject]).to eq("Activate your subscription at Daily-Random")
      expect(params[:html]).to include(subscription.token)
    end
  end

  describe "#send" do
    it "raises error if recipients aren't Array type" do
      expect{Mailer.send("maciejnowak@gmail.com")}.to raise_error
    end

    it "it sends mail with all attributes" do
      responses = Mailer.send(recipients)

      responses.each do |response|
        params = response.request.options[:params]

        expect(params[:from]).to eq("subscription@daily-random.com")
        expect(recipients).to include(params[:to])
        expect(params[:subject]).to eq("Daily random quote - #{DateTime.now.strftime("%d %B, %Y")}")
      end
    end
  end
end
