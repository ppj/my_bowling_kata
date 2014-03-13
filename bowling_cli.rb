require_relative "./bowling.rb"
require "highline/import"

class BowlingCLI

end

say (" Bowling Scorer \n----------------")

all_scores = []

begin
  entry = Hash.new
  # basic input
  entry[:name]        = ask("Player name?  ")
  entry[:game_rolls]  = ask( "Roll Scores?  (comma separated list) ",
                              lambda { |rolls| rolls.split(',') } )

  all_scores << entry
end while agree("More Players?  ", true)

all_scores.each do |score|
  score[:name] = Bowling.new()
  score[:game_rolls].each do |roll|
    score[:name].roll(roll.to_i)
  end
  say("Player: #{score[:name]}\nScore: #{score[:name].score}")
end