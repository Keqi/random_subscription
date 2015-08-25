class Subscription < ActiveRecord::Base
  validates :email, email: true
end
