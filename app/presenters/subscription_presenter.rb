class SubscriptionPresenter
  def initialize(object)
    @object = object
  end

  def icon
    active? ? "checkmark icon" : "minus circle icon"
  end

  def message_color
    active? ? "positive" : "negative" 
  end

  def render_message
    if active?
      "Your account has been activated. You will receive one email per day with random quote :)"
    else
      "Your activation link expired."
    end
  end

  private

  def active?
    @object && @object.token.nil?
  end
end
