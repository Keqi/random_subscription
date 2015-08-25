namespace :emails do
  desc "Sends daily email to every Subscriber"
  task send: :environment do
    Mailer.send(Subscription.pluck(:email))
  end
end
