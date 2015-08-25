class Mailer
  API_KEY = ENV["MAILGUN_API_KEY"]
  DOMAIN  = ENV["MAILGUN_DOMAIN"]

  def self.send(recipients)
    raise "Recipients must be an array." unless recipients.is_a? Array
    
    recipients.map do |recipient|
      request = Typhoeus::Request.new("https://api:key-#{API_KEY}@api.mailgun.net/v3/#{DOMAIN}/messages", 
                                      method: :post, 
                                      params: { from: from, 
                                                to: recipient, 
                                                subject: subject, 
                                                text: text
                                              }
                                      )
      request.run
    end
  end

  private

  def self.from
    "subscription@daily-random.com"
  end

  def self.subject
    "Daily random quote - #{date}"
  end

  def self.date
    @date ||= DateTime.now.strftime("%d %B, %Y")
  end

  def self.text
    FortuneGem.give_fortune
  end
end
