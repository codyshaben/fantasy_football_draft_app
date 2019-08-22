class User < ApplicationRecord
    has_many :teams
    has_many :player_data, through: :teams
    validates :username, presence: true, uniqueness: true
    has_secure_password
end
