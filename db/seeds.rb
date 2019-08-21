# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Player.destroy_all
Team.destroy_all

awesome_team = Team.create(name: "Awesomeness")
terrible_team = Team.create(name: "Not so awesome")

awesome_team.players.create(name: "Josh Allen", yards: 1000, touchdowns: 1000, rank: 1, position: "QB")
terrible_team.players.create(name: "Tom Brady", yards: 10, touchdowns: 0, rank: 1000, position: "QB")