describe 'players' do
    it 'shows all players names' do
        player_names = PlayerDatum.all.map {|player| player.name}
        expect(player_names == PlayerDatum.count)
    end

    it 'has a rank for every player' do 
        expect(PlayerDatum.where(rank: nil) == [])
    end
end