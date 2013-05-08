ActionMailer::Base.smtp_settings = {
  :address        => 'in.mailjet.com',
  :port           => '587',
  :authentication => :plain,
  :user_name      => ENV['8473030f2f6a78e70a830db1d29c8397'],
  :password       => ENV['b2303689584e4ef961cc9393b90bf726'],
  :domain         => 'shaipz.com'
}
ActionMailer::Base.delivery_method = :smtp
