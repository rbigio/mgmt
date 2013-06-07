class TeamMember < ActiveRecord::Base
  belongs_to :users
  belongs_to :team

  validates_presence_of :name
end
