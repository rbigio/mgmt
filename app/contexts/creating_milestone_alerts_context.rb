class CreatingMilestoneAlertsContext

  THRESHOLD = 0.15

  def initialize(milestone, user)
    @milestone = milestone
    @user = user
  end

  def create_alerts
    #create alert
    #horas estimadas por ticket cerrado
    milestoneReporter = MilestoneReporter.new(@milestone)
    alerts = milestoneReporter.create_alerts(THRESHOLD)
    alerts.each do |alert|
      AlertMailer.alert_email(@user, alert).deliver
    end
  end

end