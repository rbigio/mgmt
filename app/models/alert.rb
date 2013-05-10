class Alert < ActiveRecord::Base

  TYPE = %w(
    worked_hours
    real_time
    end_milestone
  )

  validates_presence_of :milestone
  validates_presence_of :alert_type, inclusion: {in: TYPE}
  validates_presence_of :metric

  belongs_to :milestone

end
