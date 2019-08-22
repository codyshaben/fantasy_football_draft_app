class PlayersController < ApplicationController
    def index
        if current_user
            
            @players = Player.all
        else
            render file: 'public/404.html'
        end
    end
end
