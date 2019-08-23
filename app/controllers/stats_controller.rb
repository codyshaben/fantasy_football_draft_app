class StatsController < ApplicationController
        def stats
            if current_user == nil
                render file: 'public/404.html'
            else

            @players_array = Team.all_stats
            @categories = ['Sacks', 'Interceptions', 'Tackles', 'Yards', 'Touchdowns', 'Touchdowns', '50+ Made', 'Interceptions', 'FG M', 'FG Att', 'MVP', 'Name Length', 'Name Length']
            @cat_symbols = ['sacks', 'intercepts', 'comb', 'yards', 'touchdowns', 'touchdowns', 'a_m', 'intercepts', 'fg_m', 'fg_att', 'rank', 'name', 'name']
            @headers = ['Most Sacks', 'Most Interceptions', 'Most Tackles', 'Most Yards', 'Most Touchdowns', 'Least Touchdowns', '50+ Yard FGs Made', 'Least Interceptions', 'Most FG Attempts', 'Most FG Made', 'Rank 1 Player', 'Longest Name', 'Shortest Name']
        end
    end
end
