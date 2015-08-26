namespace :emails do
  desc "Sends daily email to every Subscriber"
  task send: :environment do
    emails = Subscription.active.pluck(:email)
    Mailer.send(emails)
  end
end
