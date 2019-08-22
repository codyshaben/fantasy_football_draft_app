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

    def add_player
        if params[:z]
            @players = Team.filter_positions(params[:z])
        else
            @players = Team.top_100
        end
        @all_positions = Team.positionNameArray
        if params[:q]
            @team_id = params[:q]
        else
            @team_id = current_user.teams.first.id
        end
    end 

    def add_to_roster #params[:id] => player id || params[:team_id] => team id
        PlayerDatum.where(id: params[:id]).first.update(team_id: params[:team_id])
        render :add_player
    end

    def set_data
        redirect_to controller: 'teams', action: 'add_player', q: params[:q], z: params[:z]
    end

    private

    def team_params
        params.require(:team).permit(:name, :user_id)
    end
end
