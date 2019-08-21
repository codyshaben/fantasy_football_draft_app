class CreatePlayerData < ActiveRecord::Migration[5.2]
  def change
    create_table :player_data do |t|
      t.string :name
      t.integer :yards
      t.integer :touchdowns
      t.integer :rank
      t.string :position
      t.integer :comb
      t.float :sacks
      t.integer :intercepts
      t.integer :fg_m
      t.integer :fg_att
      t.string :a_m
      t.timestamps
    end
  end
end


