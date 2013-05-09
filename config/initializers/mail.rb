ActionMailer::Base.smtp_settings = {
  :address        => 'in.mailjet.com',
  :port           => '587',
  :enable_starttls_auto => true,
  :authentication => :plain,
  :user_name      => '8473030f2f6a78e70a830db1d29c8397',
  :password       => 'b2303689584e4ef961cc9393b90bf726',
  :domain         => 'heroku.com'
}
ActionMailer::Base.delivery_method = :smtp
