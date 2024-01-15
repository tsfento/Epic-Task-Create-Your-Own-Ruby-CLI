class Game
  attr_accessor :name, :recent_players

  @@games = []

  def initialize(name, recent_players)
    @name = name
    @recent_players = recent_players
    @@games << self
  end

  def self.all
    @@games
  end
end
