# run lambda { |env| [200, {"Content-Type" => "text/plain"}, ["Hello. The time is #{Time.now}"]] }
require './bowling'
use Rack::Reloader

rack_app = Rack::Builder.new do

  map "/" do
    run Proc.new {|env| 
      [ 200, {'Content-Type' => 'text/html'}, File.open('index.html', File::RDONLY) ]
    }
  end

  map "/score" do
    run Proc.new {|env|
      game = Bowling.new
      result = []
      req = Rack::Request.new(env)
      
      all_rolls = req.params['all_rolls']
      Rack::Response.new.finish do |res|
        res['Content-Type'] = 'text/plain'
        res.status = 200

        all_rolls.split(/,\s*/).each { |roll| game.roll(roll.to_i) }
        final_score = game.score
        result << "All Rolls: #{all_rolls.split(/,\s*/).join(" ")}"
        result << "\nFrames:\t\t1\t2\t3\t4\t5\t6\t7\t8\t9\t10"
        result << "Scores:\t\t#{game.frame_scores.join("\t")}"
        result << "\nFinal Score:\t#{final_score}"
        res.write result.join("\n")
        res
      end
    }
  end
end

Rack::Handler::WEBrick.run rack_app, :Port => 9292

#run MyApp.new
