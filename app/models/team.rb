class Team < ApplicationRecord
    belongs_to :user
    has_many :player_data
    validates :name, presence: true

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

    def self.most_defense
        most = []
        most << Team.filter_positions(5)
        most << Team.filter_positions(6)
        most << Team.filter_positions(7)
        most.flatten
    end

    def self.most_sacks
        Team.most_defense.sort_by {|player| player[:sacks]}.last
    end

    def self.most_intercepts
        Team.most_defense.sort_by {|player| player[:intercepts]}.last
    end

    def self.most_comb
        Team.most_defense.sort_by {|player| player[:comb]}.last
    end

    def self.most_def_td
        Team.most_defense.sort_by {|player| [player[:touchdowns]]}.last
    end

    def self.most_offense
        most = []
        i = 0
        while i < 4
            most << Team.filter_positions(i)
            i += 1
        end
        most.flatten
    end

    def self.most_yards
        Team.most_offense.sort_by {|player| player[:yards]}.last
    end

    def self.most_off_td 
        Team.most_offense.sort_by {|player| player[:touchdowns]}.last
    end

    def self.most_mixed
        Team.filter_positions(9).sort_by {|player| player[:a_m]}.last
    end

    def self.least_intercepts
        Team.filter_positions(0).sort_by {|player| player[:intercepts]}.first
    end





    
    def self.all_stats
        players = []
        players << Team.most_sacks
        players << Team.most_intercepts
        players << Team.most_comb
        players << Team.most_yards
        players << Team.most_off_td
        players << Team.most_def_td
        players << Team.most_mixed
        players << Team.least_intercepts
        players.flatten
    end
end
