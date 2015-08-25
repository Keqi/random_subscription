require 'rails_helper'

RSpec.describe Subscription, type: :model do
  describe "validations" do
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
end
