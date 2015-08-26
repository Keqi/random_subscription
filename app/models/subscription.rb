class Subscription < ActiveRecord::Base
  before_create :generate_token

  validates :email, uniqueness: true, email: true


  private

  def generate_token
    begin
      self.token = SecureRandom.hex(4)
    end while Subscription.exists?(token: token)
  end
end
