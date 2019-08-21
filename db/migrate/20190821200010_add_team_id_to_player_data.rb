class AddTeamIdToPlayerData < ActiveRecord::Migration[5.2]
  def change
    add_reference :player_data, :team, foreign_key: true
  end
end
