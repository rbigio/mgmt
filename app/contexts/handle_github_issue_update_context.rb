class HandleGithubIssueUpdateContext

  def initialize(github, issue, params)
    @github = github
    @issue = issue
    @params = params
    @params.delete(:github)
    @params.delete(:project)
    @params.delete(:worked_hours)

    #Rails generates a hash with an string keys, and the method resourse_params in 
    #the issue controller has a white list with symbols.
    #This line converts the string keys to symbols.
    @params = @params.inject({}){|memo,(k,v)| memo[k.to_sym] = v; memo}
  end

  def handle_issue
    raise ArgumentError, "Project cannot be nil" unless @issue
    GithubProvisioner::Issue.new(@github, @issue).sync_status!
    @issue.update_attributes(@params)
    rescue
      false
  end


end