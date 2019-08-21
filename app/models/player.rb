class Player < ApplicationRecord
    belongs_to :team
    has_one :user, through: :team
end
