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
    @roll_scores.each_with_index do |roll_score, roll_index|
      if frame_roll_index == 1
        @frame_scores.push roll_score
        if @frame_scores.length < 10 and roll_score == 10 # strike
          frame_scores[-1] += roll_scores[roll_index+1]+roll_scores[roll_index+2]
        else
          frame_roll_index = 2
        end
      else
        @frame_scores[-1] += roll_score
        if @frame_scores.length < 10
          frame_roll_index = 1
          if @frame_scores[-1]==10  # spare
            frame_scores[-1] += roll_scores[roll_index+1]
          end
        end
      end
    end
    @frame_scores.inject(0) { |total_score, frame_score| total_score + frame_score }
  end

end