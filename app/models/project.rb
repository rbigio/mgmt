require 'option'

class Project < ActiveRecord::Base

  # Validations

  validates_presence_of :organization
  validates_presence_of :name

  # Associations

  has_many :issues
  has_many :teams
  has_many :users, through: :teams, uniq: true
  has_many :milestones
  accepts_nested_attributes_for :issues, allow_destroy: true
  accepts_nested_attributes_for :milestones

  # Class Methods

  def self.by_full_name(organization, name)
    Project.where(organization: organization, name: name).first
  end

  # Instance Methods

  def open_issues
    issues.where(github_status: :open)
  end

  def current_milestone
    current_time = DateTime.now
    milestones.where("(start_date is null OR start_date <= ?) AND due_date >= ?", current_time, current_time).first
  end

  def backlog
    map = Hash.new {|h,k| h[k]=Array.new}
    (issues - Option(current_milestone).map { |m| m.issues }.get_or_else { [] }).each do |i|
      key = i.milestone_number.nil? ? -1 : i.milestone_number
      puts "before: key: #{key} map: #{map[key]}"
      map[key] << i
      puts "after: key: #{key} map: #{map[key]}"
    end
    map
  end

end
