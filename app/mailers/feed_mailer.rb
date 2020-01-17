class FeedMailer < ApplicationMailer
  def feed_mail(feed)
    @feed = feed

    mail to: "2ch.yuya@gmail.com", subject: "お問い合わせの確認メール"
  end
end
