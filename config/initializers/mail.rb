ActionMailer::Base.smtp_settings = {
  :address        => 'in.mailjet.com',
  :port           => '587',
  :enable_starttls_auto => true,
  :authentication => :plain,
  :user_name      => ENV['apikey'],
  :password       => ENV['apisecret'],
  :domain         => 'heroku.com'
}
ActionMailer::Base.delivery_method = :smtp
