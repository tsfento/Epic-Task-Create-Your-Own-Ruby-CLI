class Hunter
  attr_accessor :name, :bronze, :silver, :gold, :platinum, :points

  @@hunters = []

  def initialize(name, bronze, silver, gold, platinum, points)
    @name = name
    @bronze = bronze
    @silver = silver
    @gold = gold
    @platinum = platinum
    @points = points
    @@hunters << self
  end

  def self.all
    @@hunters
  end
end
