require 'spec_helper'

describe MilestoneReporter do

  let!(:user)                { create(:user)}
  let!(:project)             { create(:project)}
  let!(:milestone)           { create(:milestone, project: project) }
  let!(:open_issues)         { create_list(:issue, 1, project: project, milestone_number: milestone.number, status: 'not_started') }
  let!(:delivered_issues)    { create_list(:issue, 3, project: project, milestone_number: milestone.number, status: 'delivered') }
  subject(:reporter) { MilestoneReporter.new(milestone) }

  describe "#worked_hours_evaluation" do

    context "when the user has logged hours for a delivered issue" do

      let!(:work_hours_issue_0)  { create(:worked_hours_entry, amount: 5, user: user, date: Date.today-1, issue: delivered_issues[0]) }
      let!(:work_hours_issue_1)  { create(:worked_hours_entry, amount: 4, user: user, date: Date.today-2, issue: delivered_issues[1]) }
      let!(:work_hours_issue_2)  { create(:worked_hours_entry, amount: 5, user: user, date: Date.today-3, issue: delivered_issues[2]) }
  

      it "doesn't create a new Alert" do
        expect { reporter.worked_hours_evaluation(0.15) }.to change { Alert.where(milestone_id: milestone.id).count }.by 0
      end
    end

    context "when the user hasn't logged enough hours for a delivered issue" do
      let!(:work_hours_issue_0)  { create(:worked_hours_entry, amount: 5, user: user, date: Date.today-1, issue: delivered_issues[0]) }
      let!(:work_hours_issue_1)  { create(:worked_hours_entry, amount: 4, user: user, date: Date.today-2, issue: delivered_issues[1]) }
      let!(:work_hours_issue_2)  { create(:worked_hours_entry, amount: 1, user: user, date: Date.today-3, issue: delivered_issues[2]) }


      it "creates a new Alert" do
        expect { reporter.worked_hours_evaluation(0.15) }.to change { Alert.where(milestone_id: milestone.id).count }.by 1
      end
    end

    context "when the user has logged too many hours for a delivered issue" do
      let!(:work_hours_issue_0)  { create(:worked_hours_entry, amount: 5, user: user, date: Date.today-1, issue: delivered_issues[0]) }
      let!(:work_hours_issue_1)  { create(:worked_hours_entry, amount: 10, user: user, date: Date.today-2, issue: delivered_issues[1]) }
      let!(:work_hours_issue_2)  { create(:worked_hours_entry, amount: 10, user: user, date: Date.today-3, issue: delivered_issues[2]) }


      it "creates a new Alert" do
        expect { reporter.worked_hours_evaluation(0.15) }.to change { Alert.where(milestone_id: milestone.id).count }.by 1
      end
    end

  end

    describe "#real_time_evaluation" do

    #hay 5 horas estimadas por tickets abiertos
    #el milestone tiene 9.99 HEC
    context "when the user has logged hours for a delivered issue" do
      let!(:work_hours_issue_0)  { create(:worked_hours_entry, amount: 5, user: user, date: Date.today-1, issue: delivered_issues[0]) }
      it "doesn't create a new Alert" do
        expect { reporter.real_time_evaluation(0.15) }.to change { Alert.where(milestone_id: milestone.id).count }.by 0
      end
    end

    context "when the user hasn't logged enough hours for a delivered issue" do
      let!(:work_hours_issue_0)  { create(:worked_hours_entry, amount: 1, user: user, date: Date.today-1, issue: delivered_issues[0]) }

      it "creates a new Alert" do
        expect { reporter.real_time_evaluation(0.15) }.to change { Alert.where(milestone_id: milestone.id).count }.by 1
      end
    end

    context "when the user has logged too many hours for a delivered issue" do
      let!(:work_hours_issue_0)  { create(:worked_hours_entry, amount: 5, user: user, date: Date.today-1, issue: delivered_issues[0]) }
      let!(:work_hours_issue_1)  { create(:worked_hours_entry, amount: 10, user: user, date: Date.today-2, issue: delivered_issues[1]) }
      let!(:work_hours_issue_2)  { create(:worked_hours_entry, amount: 10, user: user, date: Date.today-3, issue: delivered_issues[2]) }

      it "creates a new Alert" do
        expect { reporter.real_time_evaluation(0.15) }.to change { Alert.where(milestone_id: milestone.id).count }.by 1
      end
    end

  end

     describe "#end_milestone_evaluation" do

    #HHED 9.99 / horas trabajadas
    context "when the user has logged hours for a delivered issue" do
      let!(:work_hours_issue_0)  { create(:worked_hours_entry, amount: 10, user: user, date: Date.today-1, issue: delivered_issues[0]) }
      it "doesn't create a new Alert" do
        expect { reporter.end_milestone_evaluation(0.15) }.to change { Alert.where(milestone_id: milestone.id).count }.by 0
      end
    end

    context "when the user hasn't logged enough hours for a delivered issue" do
      let!(:work_hours_issue_0)  { create(:worked_hours_entry, amount: 1, user: user, date: Date.today-1, issue: delivered_issues[0]) }

      it "creates a new Alert" do
        expect { reporter.end_milestone_evaluation(0.15) }.to change { Alert.where(milestone_id: milestone.id).count }.by 1
      end
    end

    context "when the user has logged too many hours for a delivered issue" do
      let!(:work_hours_issue_0)  { create(:worked_hours_entry, amount: 5, user: user, date: Date.today-1, issue: delivered_issues[0]) }
      let!(:work_hours_issue_1)  { create(:worked_hours_entry, amount: 10, user: user, date: Date.today-2, issue: delivered_issues[1]) }
      let!(:work_hours_issue_2)  { create(:worked_hours_entry, amount: 10, user: user, date: Date.today-3, issue: delivered_issues[2]) }

      it "creates a new Alert" do
        expect { reporter.end_milestone_evaluation(0.15) }.to change { Alert.where(milestone_id: milestone.id).count }.by 1
      end
    end

  end

end