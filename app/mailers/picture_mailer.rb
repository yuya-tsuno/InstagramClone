class PictureMailer < ApplicationMailer
  def picture_mail(picture)
    @picture = picture

    mail to: @picture.user.email , subject: "お問い合わせの確認メール"
  end
end
