module IssueHelper

  def action_visibility(issue, action)
    if Issue::TRANSITIONS[issue.status].include?(action)
      ""
    else
      "hide"
    end
  end

  def action_color(action)
    puts(action)
    case action
      when "accept" 
        "btn-success"
      when "reject" 
        "btn-danger"
      else ""
    end
  end
end