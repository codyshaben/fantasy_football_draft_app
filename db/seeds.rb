# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require_relative './scraper'

Player.destroy_all
User.destroy_all
Team.destroy_all
PlayerDatum.destroy_all

def parseScrape(url, extra=nil)
    statNames = ['Rk', 'Player', 'Pos', 'Yds', 'TD', 'Int', 'Sck', 'Comb', 'FGM', 'FG Att', 'A-M']
    scrapedArray = scrapeUrl(url, extra)
    indexes = []
    stats = {}
    scrapedArray[0].each_with_index.map do |word, index|
        statNames.map {|stat| stats[stat] = index if stat == word}
    end

    createPlayer(stats, scrapedArray)
end

#     createPlayer()

def createPlayer(hash, array)
    array.shift
    array.each do |player_stats|
        
        attr_array = ['name', 'yards', 'touchdowns', 'rank', 'position', 'comb', 'sacks', 'intercepts', 'fg_m', 'fg_att', 'a_m']
        statNames = ['Player', 'Yds', 'TD', 'Rk', 'Pos', 'Comb', 'Sck', 'Int', 'FGM', 'FG Att', 'A-M']

        newPlayer = PlayerDatum.new
        attr_array.each_with_index do |att, i|
            hash.each_pair do |k, v|
                att = att.to_sym
                if hash[statNames[i]]
                    newPlayer[att] = player_stats[hash[statNames[i]]]
                end
            end   
        end
        newPlayer.save
    end
end

i = 1
while i < 10
    if i == 1
        parseScrape("http://www.nfl.com/stats/categorystats?archive=true&conference=null&statisticPositionCategory=FIELD_GOAL_KICKER&season=2018&seasonType=REG&experience=&tabSeq=1&qualified=true&Submit=Go", 1)
    end

    if i < 3
        parseScrape("http://www.nfl.com/stats/categorystats?tabSeq=1&season=2018&seasonType=REG&Submit=Go&experience=&archive=true&conference=null&d-447263-p=#{i}&statisticPositionCategory=QUARTERBACK&qualified=true")
    end

    if i < 4
        parseScrape("http://www.nfl.com/stats/categorystats?tabSeq=1&season=2018&seasonType=REG&Submit=Go&experience=&archive=true&d-447263-p=#{i}&conference=null&statisticPositionCategory=RUNNING_BACK&qualified=true")
        parseScrape("http://www.nfl.com/stats/categorystats?tabSeq=1&season=2018&seasonType=REG&Submit=Go&experience=&archive=true&d-447263-p=#{i}&conference=null&statisticPositionCategory=TIGHT_END&qualified=true")
        parseScrape("http://www.nfl.com/stats/categorystats?tabSeq=1&season=2018&seasonType=REG&Submit=Go&experience=&archive=true&d-447263-p=#{i}&conference=null&statisticPositionCategory=KICK_RETURNER&qualified=false", 1)
        parseScrape("http://www.nfl.com/stats/categorystats?tabSeq=1&season=2018&seasonType=REG&Submit=Go&experience=&archive=true&d-447263-p=#{i}&conference=null&statisticPositionCategory=PUNT_RETURNER&qualified=false", 1)
    end

    if i < 6
        parseScrape("http://www.nfl.com/stats/categorystats?tabSeq=1&season=2018&seasonType=REG&Submit=Go&experience=&archive=true&d-447263-p=#{i}&conference=null&statisticPositionCategory=WIDE_RECEIVER&qualified=false")
    end

    if i < 6
        parseScrape("http://www.nfl.com/stats/categorystats?tabSeq=1&season=2018&seasonType=REG&Submit=Go&experience=&archive=true&d-447263-p=#{i}&conference=null&statisticPositionCategory=LINEBACKER&qualified=false", 1)
        parseScrape("http://www.nfl.com/stats/categorystats?tabSeq=1&season=2018&seasonType=REG&Submit=Go&experience=&archive=true&d-447263-p=#{i}&conference=null&statisticPositionCategory=DEFENSIVE_LINEMAN&qualified=false", 1)
    end
    
    if i < 9
        parseScrape("http://www.nfl.com/stats/categorystats?tabSeq=1&season=2018&seasonType=REG&Submit=Go&experience=&archive=true&d-447263-p=#{i}&conference=null&statisticPositionCategory=DEFENSIVE_BACK&qualified=true", 1)
    end
    i += 1
end
 