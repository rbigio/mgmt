class CreatingMilestoneAlertsContext

  def initialize(milestone)
    @milestone = milestone
  end

  def create_alerts
    #create alert
    #horas estimadas por ticket cerrado
    milestoneReporter = MilestoneReporter.new(@milestone)
    alerts = milestoneReporter.create_alerts(@milestone)
  end

end