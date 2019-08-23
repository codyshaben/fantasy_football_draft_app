describe 'team' do
    it 'can create team' do
        team = Team.new
        expect(team.save == true)
    end

    it 'can create user' do
        user = User.new
        expect(user.save == true)
    end

    it 'can add player to team' do 
        player = PlayerDatum.new
        user = User.new
        team = Team.new
        team.id = 1
        player.team_id = team.id
        expect(player.team_id = team.id)
    end
end