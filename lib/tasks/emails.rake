namespace :emails do
  desc "Sends daily email to every Subscriber"
  task send: :environment do
    emails = Subscription.active.pluck(:email)
    Mailer.send(emails)
  end

  desc "Remove subscriptions that have not been activated in 7 days."
  task remove_expired: :environment do
    Subscription.expired.delete_all
  end
end
