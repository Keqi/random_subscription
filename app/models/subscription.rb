class Subscription < ActiveRecord::Base
  before_create :generate_token

  validates :email, uniqueness: true, email: true

  scope :active, -> { where(token: nil) }
  scope :expired, -> { where.not(token: nil).where("created_at < :date", date: 7.days.ago) }

  def activate
    update_attribute(:token, nil)
  end

  private

  def generate_token
    begin
      self.token = SecureRandom.hex(4)
    end while Subscription.exists?(token: token)
  end
end
