require 'rspec'
require_relative '../bowling.rb'

describe Bowling do

  def hit_spare firstRoll
    subject.roll(firstRoll)
    subject.roll(10-firstRoll)
  end

  context "A single player" do

    it "cannot hit less than 0 or more than 10 pins in a roll" do
      expect {subject.roll(12)}.to raise_error("invalid roll-score")
    end

    it "cannot roll more than 21 times" do
      21.times {subject.roll(5)}
      expect{subject.roll(3)}.to raise_error("game is definitely over")
    end

    it "can see the roll scores stored" do
      rolls=[4,3,6,4,3,2,4,3,2,4,3,2,4,3,2,4,3,2,1,5]
      rolls.each {|pins| subject.roll(pins)}
      subject.roll_scores.should == rolls
    end

    it "can see the frame scores stored" do
      rolls=[ 7,3, 4,0, 0,0, 0,0, 0,0, 0,0, 0,0, 0,0, 0,0, 0,0 ]
      rolls.each {|pins| subject.roll(pins)}
      subject.score
      subject.frame_scores.should == [14,4,0,0,0,0,0,0,0,0]
    end

    context "when hits no spares or strikes" do
      it "can roll exactly twice in each of the 10 frames" do
        20.times {subject.roll(1)}
        expect{subject.roll(3)}.to raise_error("game is over")
      end
    end

    context "when rolls 20 gutter balls" do
      it "scores 0" do
        20.times {subject.roll(0)}
        subject.score.should eql(0)
      end
    end

    context "when hits 1 pin in two consecutive rolls" do
      it "scores 2" do
        18.times { subject.roll(0) }
        2.times  { subject.roll(1) }
        subject.score.should eql(2)
      end
    end

    context "when hits total 10 pins in consecutive rolls in 2 different frames" do
      it "scores 10" do
        subject.roll(0)
        2.times  { subject.roll(5) }
        17.times { subject.roll(0) }
        subject.score.should eql(10)
      end
    end

    context "when hits a spare" do
      it "scores double the next roll" do
        16.times {subject.roll(1)}
        hit_spare 5
        subject.roll(4)
        subject.roll(1)
        subject.score.should == (35)
      end
    end

    context "when hits 5 pins in each roll (all spares)" do
      it "scores 150" do
        #21.times {subject.roll(5)}
        10.times {hit_spare 5}
        subject.roll(5)
        subject.score.should eql(150)
      end
    end

    context "when hits 7+3 pins respectively in each frame (all spares)" do
      it "scores 170" do
        10.times {
          #subject.roll(7)
          #subject.roll(3)
          hit_spare(7)
        }
        subject.roll(7)
        subject.score.should eql(170)
      end
    end

    context "when hits one or many (non-consecutive) strikes" do
      it "gets next two rolls as bonus points for the strike frame" do
        subject.roll(10)
        subject.roll(3)
        subject.roll(4)
        subject.roll(10)
        subject.roll(1)
        subject.roll(2)
        14.times {subject.roll(0)}
        subject.score
        subject.frame_scores.should == [17,7,13,3,0,0,0,0,0,0]
      end
    end

    #context "when hits consecutive strikes in the first 2 frames" do
    #  it "gets next two rolls as bonus points for the strike frame" do
    #    2.times {subject.roll(10)}
    #    subject.roll(1)
    #    subject.roll(4)
    #    14.times {subject.roll(0)}
    #    subject.score
    #    subject.frame_scores.should == [21,15,5,0,0,0,0,0,0,0]
    #  end
    #end

  end

end