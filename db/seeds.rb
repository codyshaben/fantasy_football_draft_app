# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require_relative './scraper'

Team.destroy_all
PlayerDatum.destroy_all

bill = User.where(name: "bill").first
Team.create(name: "Bills", user_id: bill.id)
Team.create(name: "Not Bills", user_id: bill.id)


def parseScrape(url, extra=nil)
    statNames = ['Player', 'Yds', 'TD', 'Rk', 'Pos', 'Comb', 'Sck', 'Int', 'FGM', 'FG Att', 'A-M']
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
        intStats = ['yards', 'touchdowns', 'rank', 'comb', 'sacks', 'intercepts', 'fg_m', 'fg_att']

        newPlayer = PlayerDatum.new
        attr_array.each_with_index do |att, index|
            hash.each_pair do |k, val|
                att = att.to_sym
                if hash[statNames[index]]
                    newPlayer[att] = player_stats[hash[statNames[index]]]
                end
            end   
        end
        intStats.map {|stat| newPlayer[stat.to_sym] = 0 if newPlayer[stat.to_sym] == nil}
        newPlayer.save
    end
end

i = 1
while i < 10
    if i == 1
        parseScrape("http://www.nfl.com/stats/categorystats?archive=true&conference=null&statisticPositionCategory=FIELD_GOAL_KICKER&season=2018&seasonType=REG&experience=&tabSeq=1&qualified=true&Submit=Go", 1)
        parseScrape("http://www.nfl.com/stats/categorystats?tabSeq=1&season=2018&seasonType=REG&Submit=Go&experience=&archive=true&conference=null&d-447263-p=#{i}&statisticPositionCategory=QUARTERBACK&qualified=true")



        parseScrape("http://www.nfl.com/stats/categorystats?tabSeq=1&season=2018&seasonType=REG&Submit=Go&experience=&archive=true&d-447263-p=#{i}&conference=null&statisticPositionCategory=RUNNING_BACK&qualified=true")
        parseScrape("http://www.nfl.com/stats/categorystats?tabSeq=1&season=2018&seasonType=REG&Submit=Go&experience=&archive=true&d-447263-p=#{i}&conference=null&statisticPositionCategory=TIGHT_END&qualified=true")
        parseScrape("http://www.nfl.com/stats/categorystats?tabSeq=1&season=2018&seasonType=REG&Submit=Go&experience=&archive=true&d-447263-p=#{i}&conference=null&statisticPositionCategory=KICK_RETURNER&qualified=false", 1)
        parseScrape("http://www.nfl.com/stats/categorystats?tabSeq=1&season=2018&seasonType=REG&Submit=Go&experience=&archive=true&d-447263-p=#{i}&conference=null&statisticPositionCategory=PUNT_RETURNER&qualified=false", 1)



        parseScrape("http://www.nfl.com/stats/categorystats?tabSeq=1&season=2018&seasonType=REG&Submit=Go&experience=&archive=true&d-447263-p=#{i}&conference=null&statisticPositionCategory=WIDE_RECEIVER&qualified=false")


        parseScrape("http://www.nfl.com/stats/categorystats?tabSeq=1&season=2018&seasonType=REG&Submit=Go&experience=&archive=true&d-447263-p=#{i}&conference=null&statisticPositionCategory=LINEBACKER&qualified=false", 1)
        parseScrape("http://www.nfl.com/stats/categorystats?tabSeq=1&season=2018&seasonType=REG&Submit=Go&experience=&archive=true&d-447263-p=#{i}&conference=null&statisticPositionCategory=DEFENSIVE_LINEMAN&qualified=false", 1)


        parseScrape("http://www.nfl.com/stats/categorystats?tabSeq=1&season=2018&seasonType=REG&Submit=Go&experience=&archive=true&d-447263-p=#{i}&conference=null&statisticPositionCategory=DEFENSIVE_BACK&qualified=true", 1)
    end
    i += 1
end