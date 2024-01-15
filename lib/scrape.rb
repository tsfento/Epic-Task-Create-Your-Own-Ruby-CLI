require 'nokogiri'
require 'open-uri'
require_relative 'game'
require_relative 'hunter'

class Scrape
  SCRAPE_URL = 'https://psnprofiles.com/'

  def self.get_popular
    doc = Nokogiri::HTML(URI.open(SCRAPE_URL + 'games?order=popular'))
    played_table = doc.css('#game_list tr')

    played_table[0..9].each do |game_row|
      name = game_row.css('.title').text.strip
      recent_players = game_row.css('.small-info b')[1].text.strip

      Game.new(name, recent_players)
    end
  end

  def self.get_hunters
    doc = Nokogiri::HTML(URI.open(SCRAPE_URL + 'leaderboard'))
    hunters_table = doc.css('#leaderboard tr')

    hunters_table[1..10].each do |hunter_row|
      name = hunter_row.css('.title').text.strip
      bronze = hunter_row.css('.bronze')[0]&.text&.strip || '0'
      silver = hunter_row.css('.silver')[0]&.text&.strip || '0'
      gold = hunter_row.css('.gold')[0]&.text&.strip || '0'
      platinum = hunter_row.css('.platinum')[0]&.text&.strip || '0'
      points = hunter_row.css('.points')[0]&.text&.strip || '0'

      Hunter.new(name, bronze, silver, gold, platinum, points)
    end
  end
end
