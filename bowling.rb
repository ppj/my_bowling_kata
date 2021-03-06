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

  def rollscore_available? roll_index
    roll_index < @roll_scores.length
  end

  def is_strike? roll_index
    @roll_scores[roll_index]==10
  end

  def strike_bonus roll_index
    if rollscore_available? roll_index+2
      @roll_scores[roll_index+1]+@roll_scores[roll_index+2]
    else
      if rollscore_available? roll_index+1
        @roll_scores[roll_index+1]
      else
        0
      end
    end
  end

  def is_spare? roll_index
    if rollscore_available? roll_index+1
      @roll_scores[roll_index] + @roll_scores[roll_index+1] == 10
    else
      false
    end
  end

  def spare_bonus roll_index
    if rollscore_available? roll_index+2
      @roll_scores[roll_index+2]
    else
      0
    end
  end

  def score_10th_frame roll_index
    if rollscore_available?(roll_index+1)
      @frame_scores[-1] += roll_scores[roll_index+1]
    end
    if @frame_scores[-1] >= 10 && rollscore_available?(roll_index+2)
      @frame_scores[-1] += roll_scores[roll_index+2]
    end
  end

  def calculate_frame_scores
    roll_index = 0
    10.times do
      unless rollscore_available?(roll_index)
        break
      end
      frame_scores.push roll_scores[roll_index]
      if @frame_scores.length < 10
        if is_strike? roll_index
          @frame_scores[-1] += strike_bonus(roll_index)
          roll_index += 1
        else
          frame_scores[-1] += roll_scores[roll_index+1] if rollscore_available?(roll_index+1)
          if is_spare? roll_index
            @frame_scores[-1] += spare_bonus(roll_index)
          end
          roll_index += 2
        end
      else
        score_10th_frame roll_index
      end
    end
  end

  def score
    calculate_frame_scores
    @frame_scores.inject(0) { |total_score, frame_score | total_score + frame_score }
  end

end