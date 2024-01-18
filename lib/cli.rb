require_relative 'scrape'
require_relative 'game'
require_relative 'hunter'
require_relative 'user'
require 'io/console'

class CLI
  def initialize
    @username = ''
  end

  def execute
    User.load_users_from_file
    authenticate
    system('clear')
    greet
    while menu != '5'
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
    puts '3. Reset password'
    puts '4. Sign out'
    puts '5. Exit'

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
    when '3'
      puts "\nPlease enter a new password:"
      new_password = STDIN.noecho(&:gets).chomp
      User.reset_password(@username, new_password)
    when '4'
      puts "\nCome back soon!"
      puts "\n"
      authenticate
    end

    option_num
  end

  def end_program
    puts 'Goodbye!'
    exit(true)
  end

  def authenticate
    authenticated = false

    until authenticated
      puts 'Please login or sign up'
      puts 'Which do you choose? (sign up/login)'
      get_input = gets.chomp

      if get_input == 'login'
        authenticated = login
      elsif get_input == 'sign up'
        create_user
      elsif get_input == 'exit'
        end_program
      else
        puts 'Please enter a vaild option'
      end
    end
  end

  def login
    puts 'Please enter your username'
    @username = gets.chomp
    puts 'Please enter your password'
    # password = gets.chomp
    password = STDIN.noecho(&:gets).chomp

    result = User.authenticate(@username, password)

    if result
      puts "Welcome back #{@username}"
    else
      puts 'Invalid username or password'
    end

    result
  end

  def create_user
    puts 'Please enter your username'
    @username = gets.chomp
    puts 'Please enter your password'
    # password = gets.chomp
    password = STDIN.noecho(&:gets).chomp

    user = User.new(@username, password)
    User.store_credentials(user)
    puts 'User created. Login to continue'
  end
end
