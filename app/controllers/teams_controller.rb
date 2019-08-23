class TeamsController < ApplicationController

    def index
        if current_user == nil
            render file: 'public/404.html'
        else
            @teams = User.where(id: current_user.id).first.teams
        end
    end

    def new
        if current_user == nil
            render file: 'public/404.html'
        else
            @team = Team.new
        end
    end
    
    def create
        @team = Team.new(team_params)
        
        @team.user_id = current_user.id
        if (@team.save)
            redirect_to '/teams'
        else
            render :new
        end
    end

    def destroy
        if current_user.teams.count > 1
            PlayerDatum.where(team_id: params[:team_id]).map {|player| player.update(team_id: nil)}
            Team.destroy(params[:team_id])
            redirect_to '/teams'
        else
            flash[:alert] = "You shouldn't delete your only team!"
            redirect_to '/teams'
        end
    end

    def add_player
        if current_user == nil
            render file: 'public/404.html'
        else

            @user = current_user
            if params[:z]
                @players = Team.filter_positions(params[:z])
                @z_param = params[:z]
                @filter = Team.positionNameHash[params[:z].to_i][:name] + 's'
            else
                @players = Team.top_100
                @filter = "Top 100 Players"
            end

            @all_positions = Team.positionNameHash


            if params[:q]
                @team_id = params[:q]
            else
                @team_id = current_user.teams.first.id
            end
        end
    end 

    def add_to_roster #params[:id] => player id || params[:team_id] => team id
        PlayerDatum.where(id: params[:id]).first.update(team_id: params[:team_id])
        redirect_to controller: 'teams', action: 'add_player', q: params[:team_id], z: params[:category]
    end

    def set_data
        @all_positions = Team.positionNameHash
        redirect_to controller: 'teams', action: 'add_player', q: params[:q], z: params[:z]
    end

    def delete_from_roster
        PlayerDatum.where(id: params[:player_id].to_i).update(team_id: nil)
        redirect_to '/teams'
    end

    def rename_team
        Team.where(id: params[:team_id]).update(name: params[:team_name])
        redirect_to '/teams'
    end
    
    def stats
        if current_user == nil
            render file: 'public/404.html'
        else
            @players_array = Team.all_stats
            @categories = ['Sacks', 'Interceptions', 'Tackles', 'Yards', 'Touchdowns', 'Touchdowns', '50+ Made', 'Interceptions']
            @cat_symbols = ['sacks', 'intercepts', 'comb', 'yards', 'touchdowns', 'touchdowns', 'a_m', 'intercepts']
            @headers = ['Most Sacks', 'Most Interceptions', 'Most Tackles', 'Most Yards', 'Most Touchdowns', 'Least Touchdowns', 'Most FG Made at 50+ Yards', 'Least Interceptions']
        end
    end

    private

    def team_params
        params.require(:team).permit(:name)
    end
end
