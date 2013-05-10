class MilestoneReporter < SimpleDelegator

  # Instance Methods

  def initialize(milestone)
    super(milestone)
    @milestone = milestone
  end

  def create_alerts(threshold)
    alerts = []
    alerts ||= worked_hours_evaluation(threshold)
    alerts ||= real_time_evaluation(threshold)
    alerts ||= end_milestone_evaluation(threshold)
    alerts
  end

  # Calculates the ratio between the estimated hours for delivered 
  # tickets and the hours that where actually worked.
  # If the ratio is over the threshold then an alert is created
  def worked_hours_evaluation(threshold) 
    delivered_estimated_hours = delivered_issues_estimated_hours
    return if delivered_estimated_hours == 0
    evaluation_ratio = delivered_total_worked_hours / delivered_estimated_hours

    if (evaluation_ratio - 1).abs  > threshold
      Alert.create!({milestone: @milestone, metric: evaluation_ratio, alert_type: 'worked_hours'})
    end
  end

  # Calculates the ratio between the sum of worked hours and the estimated
  # hours for not delivered tickets and the hours that were estimated to the client
  # If the ratio is over the threshold then an alert is created
  def real_time_evaluation(threshold)
    evaluation_ratio = (total_worked_hours +  opened_issues_estimated_hours) / @milestone.client_estimated_hours
    if (evaluation_ratio - 1).abs  > threshold
      Alert.create!({milestone: @milestone, metric: evaluation_ratio, alert_type: 'real_time'})
    end
  end

  # Calculates the ratio between the estimated hours for the milestone
  # and the total worked hours
  # If the ratio is over the threshold then an alert is created
  def end_milestone_evaluation(threshold) 
    worked_hours = total_worked_hours
    return if worked_hours == 0
    evaluation_ratio = @milestone.estimated_hours / total_worked_hours
    if (evaluation_ratio - 1).abs  > threshold
      Alert.create!({milestone: @milestone, metric: evaluation_ratio, alert_type: 'end_milestone'})
    end
  end

  private

    def opened_issues_estimated_hours
      issues = Issue.where(milestone_number: @milestone.number).where.not(status: 'delivered')
      issues.reduce(0) { |sum, issue| issue.estimated_hours + sum }
    end

    def delivered_issues_estimated_hours
      issues = Issue.where({milestone_number: @milestone.number, status: 'delivered'})
      issues.reduce(0) { |sum, issue| issue.estimated_hours + sum }
    end

    def opened_issues_worked_hours
      issues = Issue.where(milestone_number: @milestone.number)
                    .not(status: 'delivered')
      issues.reduce(0) { |sum, issue| issue.worked_hours + sum }
    end

    def delivered_total_worked_hours
      issues = Issue.where({milestone_number: @milestone.number, status: 'delivered'})
      issues.reduce(0) { |sum, issue| issue.worked_hours + sum }
    end

    def total_worked_hours
      issues = Issue.where(milestone_number: @milestone.number)
      issues.reduce(0) { |sum, issue| issue.worked_hours + sum }
    end

end