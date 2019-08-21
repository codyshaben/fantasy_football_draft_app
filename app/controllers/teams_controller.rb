class TeamsController < ApplicationController
    def index
        @teams = Team.all
    end
    
    def create
    end
end
