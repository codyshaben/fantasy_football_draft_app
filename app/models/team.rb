class Team < ApplicationRecord
    belongs_to :user
    has_many :player_data


    def self.positionNameHash
        positions =  [{name: 'Quarterback', id: 0},
                     {name: 'Runningback', id: 1},
                     {name: 'Wide Receiver', id: 2},
                     {name: 'Tight End', id: 3},
                     {name: 'Defensive Line',id: 4},
                     {name: 'Linebacker', id: 5},
                     {name: 'Defensive Back', id: 6},
                     {name: 'Kick Returner', id: 7},
                     {name: 'Punt Returner', id: 8},
                     {name: 'Field Goal Kicker', id: 9}]
        positions
    end


    def self.positionSymbols
        positionArray = [['QB'], #quarterbacks
        ['RB', 'FB'],
        ['WR'],
        ['TE'],
        ['DE', 'DT', 'NT'],
        ['OLB', 'ILB', 'MLB', 'LB'],
        ['FS', 'SS', 'DB', 'CB'],
        ['DB', 'WR', 'RB', 'FS', 'CB', 'FB'],
        ['WR', 'RB', 'CB'],
        ['K']]

        positionArray
    end

    def self.filter_positions(index)
        symbolArray = Team.positionSymbols[index.to_i]
        playerArray = []
        symbolArray.each do |pos_sym|
            PlayerDatum.where(team_id: nil).where(position: pos_sym).map {|player| playerArray << player}
        end

        playerArray = playerArray.sort_by {|player| player[:rank]}

        if playerArray.count >= 100
            playerArray = playerArray[0..99]
        else
            playerArray = playerArray[0..playerArray.length]
        end

        playerArray
    end

    def self.top_100
        PlayerDatum.where(team_id: nil).order(rank: :asc)[0..99]
    end
end
