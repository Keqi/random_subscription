require 'rails_helper'

RSpec.describe SubscriptionsController, :type => :controller do
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
end
