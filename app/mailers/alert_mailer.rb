class AlertMailer < ActionMailer::Base

  def alert_email(user, alert)
    @user = user
    @alert = alert
    mail(to: @user.email, subject: t("views.#{alert.alert_type}.subject"))
  end

end
