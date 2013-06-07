class CreateTeamMembers < ActiveRecord::Migration
  def change
    create_table :team_members do |t|
      t.references :users, index: true
      t.references :team, index: true
      t.integer :dedication

      t.timestamps
    end
  end
end
