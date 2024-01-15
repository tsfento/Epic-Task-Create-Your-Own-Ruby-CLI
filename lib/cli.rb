require_relative 'scrape'
require_relative 'game'
require_relative 'hunter'

class CLI
  def execute
    system('clear')
    greet
    while menu != '3'
    end
    end_program
  end

  def greet
    puts 'Welcome to the PSNProfiles scraper!'
  end

  def menu
    puts "\nChoose an option:"
    puts "\n1. Show the Current Week Top 10 Popular Playstation Games"
    puts '2. Show the Current Top Ten Trophy Hunters'
    puts '3. Exit'

    option_num = gets.chomp

    case option_num
    when '1'
      Scrape.get_popular

      puts "\nListing Top 10 Popular Playstation Games.."
      puts "\n"
      Game.all.each_with_index do |game, index|
        puts "#{'%02i' % (index + 1).to_s}. Name: #{game.name}"
        puts "Recent Players: #{game.recent_players}"
        puts '-------------------------------'
      end
    when '2'
      Scrape.get_hunters

      puts "\nListing Current Top 10 Trophy Hunters.."
      puts "\n"
      Hunter.all.each_with_index do |hunter, index|
        puts "#{'%02i' % (index + 1).to_s}. Name: #{hunter.name}"
        puts "Bronze Trophies: #{hunter.bronze}"
        puts "Silver Trophies: #{hunter.silver}"
        puts "Gold Trophies: #{hunter.gold}"
        puts "Platinum Trophies: #{hunter.platinum}"
        puts "Total Points: #{hunter.points}"
        puts '-------------------------------'
      end
    end

    option_num
  end

  def end_program
    puts 'Goodbye!'
  end
end
