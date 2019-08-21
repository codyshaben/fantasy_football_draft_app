class CreatePlayers < ActiveRecord::Migration[5.2]
  def change
    create_table :players do |t|
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

      t.timestamps
    end
  end
end
