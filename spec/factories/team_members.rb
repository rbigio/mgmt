# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :team_member do
    users nil
    team nil
    dedication 1
  end
end
