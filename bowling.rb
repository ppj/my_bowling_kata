class Bowling
  attr_accessor :roll_scores, :frame_scores

  def initialize
    @roll_scores = []
    @frame_scores = []
  end

  def roll(pins)
    if 0 > pins or pins > 10
      raise "invalid roll-score"
    end
    if @roll_scores.length > 20
      raise "game is definitely over"
    end
    if @roll_scores.length == 20
      if @roll_scores[18]+@roll_scores[19] < 10
        raise "game is over"
      end
    end
    @roll_scores.push(pins)
  end

  def score
    frame_roll_index = 1
    spare_flag = false
    strike_flag = 0
    @roll_scores.each do |roll_score|
      if spare_flag
        @frame_scores[-1] += roll_score
        spare_flag = false
      end
      if strike_flag > 0
        @frame_scores[strike_flag-3] += roll_score
        strike_flag -= 1 if roll_score < 10
      end
      if frame_roll_index == 1
        @frame_scores.push roll_score
        if @frame_scores.length < 10 and roll_score == 10
          strike_flag == 0 ? strike_flag = 2 : strike_flag += 1
        else
          frame_roll_index = 2
        end
        #roll_score != 10 ? frame_roll_index = 2: strike_flag = 2
      else
        @frame_scores[-1] += roll_score
        if @frame_scores.length < 10
          frame_roll_index = 1
          spare_flag = @frame_scores[-1]==10
        end
      end
    end
    @frame_scores.inject(0) { |total_score, frame_score| total_score + frame_score }
  end

end