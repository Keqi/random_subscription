require 'rails_helper'

RSpec.describe Subscription, type: :model do
  describe "#activate" do
    it "updates token to nil" do
      subscription = Subscription.create!(email: "maciejnowak@gmail.com")
      subscription.activate

      expect(subscription.token).to be_nil
    end
  end

  describe "validations" do
    describe "email format" do
      it "is not valid when email is blank" do
        subscription = Subscription.new(email: nil)
        expect(subscription.valid?).not_to eq(true)
      end

      it "is not valid when email is not in email format" do
        subscription = Subscription.new(email: "maciejnowak.com")
        expect(subscription.valid?).not_to eq(true)
      end

      it "is valid when email is in email format" do
        subscription = Subscription.new(email: "maciejnowak@gmail.com")
        expect(subscription.valid?).to eq(true)
      end
    end

    describe "uniqueness" do
      it "is not valid if email is not unique" do
        subscription = Subscription.create!(email: "maciejnowak@gmail.com")

        new_subscription = Subscription.new(email: "maciejnowak@gmail.com")
        expect(new_subscription.valid?).not_to eq(true)
      end

      it "is valid if email is unique" do
        subscription = Subscription.create!(email: "maciejnowak@gmail.com")

        new_subscription = Subscription.new(email: "maciejnowak1@gmail.com")
        expect(new_subscription.valid?).to eq(true)
      end
    end
  end

  describe "callbacks" do
    it "generates unique token before creation" do
      subscription = Subscription.new(email: "maciejnowak@gmail.com")
      subscription.save!

      expect(subscription.token).not_to be_nil
      expect(subscription.token.length).to eq(8)
    end
  end

  describe "scopes" do
    describe "#active" do
      it "returns only subscriptions that are active" do
        active_subscription = Subscription.create!(email: "maciejnowak@gmail.com")
        subscription = Subscription.create!(email: "maciejnowak1@gmail.com")

        active_subscription.activate

        expect(Subscription.active).to include(active_subscription)
        expect(Subscription.active).not_to include(subscription)
      end
    end
  end
end
