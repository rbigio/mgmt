require 'spec_helper'

describe CreatingMilestoneAlertsContext do

  let!(:user)                { create(:user)}
  let!(:project)             { create(:project)}
  let!(:milestone)           { create(:milestone, project: project, client_estimated_hours: 20, estimated_hours: 15) }
  let!(:open_issues)         { create_list(:issue, 1, project: project, milestone_number: milestone.number, status: 'not_started') }
  let!(:delivered_issues)    { create_list(:issue, 3, project: project, milestone_number: milestone.number, status: 'delivered') }

  def create_work_hours(*traits)
    attrs = traits.extract_options!
    traits.push({
      :amount => 1,
      :user => user,
      :date => Date.today
    }.merge(attrs))
    create(:worked_hours_entry, *traits)
  end

  describe "#deliver_mail_alert" do

    context "when the treshold is surpassed" do

      let!(:work_hours_issue_0)  { create_work_hours(amount: 5, date: Date.today-1, issue: delivered_issues[0]) }
      let!(:work_hours_issue_1)  { create_work_hours(amount: 4, date: Date.today-2, issue: delivered_issues[1]) }
      let!(:work_hours_issue_2)  { create_work_hours(amount: 1, date: Date.today-3, issue: delivered_issues[2]) }

      it "does deliver the mail alert" do
        context = CreatingMilestoneAlertsContext.new(milestone, user)
        expect { context.create_alerts }.to change { ActionMailer::Base.deliveries.count }.by 3
      end

    end

    context "when the treshold is not surpassed" do
      let!(:work_hours_issue_0)  { create_work_hours(amount: 5, date: Date.today-1, issue: delivered_issues[0]) }
      let!(:work_hours_issue_1)  { create_work_hours(amount: 4, date: Date.today-2, issue: delivered_issues[1]) }
      let!(:work_hours_issue_2)  { create_work_hours(amount: 5, date: Date.today-3, issue: delivered_issues[2]) }
  

      it "doesn't deliver a new Alert" do
        context = CreatingMilestoneAlertsContext.new(milestone, user)
        expect { context.create_alerts }.to change { ActionMailer::Base.deliveries.count }.by 0
      end
    end

  end

end