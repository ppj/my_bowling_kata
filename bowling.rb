class Bowling
  attr_reader :score, :frame_score

  def initialize
    @score = 0
    @roll_counter = 0
    @frame_score = 0
    @extra_roll = false
  end

  def roll(pins)
    if pins > 10
      raise "invalid roll-score"
    end
    @roll_counter+=1
    if @roll_counter > 21
      raise "game is definitely over"
    end
    @frame_score == 10 ? @score += pins :
    if @roll_counter == 21 and @frame_score < 10
      raise "game is over"
    end
    if @roll_counter%2 == 0 and @roll_counter < 21
      @frame_score+=pins
    else
      @frame_score=pins
    end
    if @roll_counter < 21
      @score += pins
    end

  end

end