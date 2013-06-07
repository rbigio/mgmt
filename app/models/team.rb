class Team < ActiveRecord::Base
  belongs_to :project
  has_many :team_members
end
