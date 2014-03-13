require_relative "./bowling.rb"
require "highline/import"

class BowlingCLI

end

say (" Bowling Scorer \n----------------")

all_rolls = []

begin
  entry = Hash.new
  # basic input
  entry[:name]        = ask("Player name?  ", lambda {|name| name.strip}) do |q|
    q.validate = /\w+/
  end
  entry[:game_rolls]  = ask( "Roll Scores?  (comma separated list) ",
                              lambda { |rolls| rolls.split(/,\s*/) } ) do |q|
    q.validate = lambda { |p| p.split(/,\s*/).length <= 21}
    q.responses[:not_valid] = "Invalid roll count (>21). Re-enter..."
    #q.validate = lambda do |p|
    #  v = true
    #  p.split(/.\s*/).each {|r| v = (v and (r.to_i <= 10))}
    #  return v
    #end
    #q.responses[:not_valid] = "One or more roll-scores invalid (>10). Re-enter the whole thing!..."
  end
  puts entry[:game_rolls].join("-")

  all_rolls << entry
end while agree("More Players?  ", true)

all_scores = Hash.new
all_rolls.each do |player_rolls|
  temp = Bowling.new()
  player_rolls[:game_rolls].each do |single_roll|
    temp.roll(single_roll.to_i)
  end
  all_scores[player_rolls[:name]] = temp.score
end
all_scores.each { |player, final_score| say("Player: #{player}\nScore: #{final_score}\n") }
