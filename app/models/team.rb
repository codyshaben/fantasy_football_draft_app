class Team < ApplicationRecord
    belongs_to :user
    has_many :player_data
end
