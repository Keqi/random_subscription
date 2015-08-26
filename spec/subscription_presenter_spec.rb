require 'rails_helper'

RSpec.describe SubscriptionPresenter, type: :presenters do
  context "when activated" do
    let(:subscription) { Subscription.create!(email: "maciejnowak@gmail.com") }
    subject { SubscriptionPresenter.new(subscription) }

    before { subscription.activate }

    it "returns checkmark icon" do
      expect(subject.icon).to eq("checkmark icon")
    end

    it "returns positive color" do
      expect(subject.message_color).to eq("positive")
    end

    it "returns activated subcription message" do
      expect(subject.render_message).to eq("Your account has been activated.")
    end
  end

  context "when deactivated" do
    let(:subscription) { Subscription.create!(email: "maciejnowak@gmail.com") }
    subject { SubscriptionPresenter.new(subscription) }

    it "returns checkmark icon" do
      expect(subject.icon).to eq("minus circle icon")
    end

    it "returns positive color" do
      expect(subject.message_color).to eq("negative")
    end

    it "returns activated subcription message" do
      expect(subject.render_message).to eq("Your activation link expired.")
    end
  end
end
