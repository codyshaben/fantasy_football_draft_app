class TeamsController < ApplicationController
    def index
        @teams = Team.all
    end
    
    def create
        @team = Team.new(team_params)

        if (@team.save)
            redirect_to teams_path
        else
            render :index
        end
    end

    private

    def team_params
        params.require(:team).permit(:name, :user_id)
    end
end
