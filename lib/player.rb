class Player
  attr_reader :name

  attr_accessor :wins, :losses

  def initialize(name)
    @name = name
    @losses = 0
    @wins = 0
  end
end
