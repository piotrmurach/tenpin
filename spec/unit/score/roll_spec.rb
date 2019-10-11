# frozen_string_literal: true

RSpec.describe Tenpin::Score, "#roll" do
  it "initializes score by default to 0" do
    score = Tenpin::Score.new

    expect(score.total).to eq(0)
  end

  it "bowls two rolls in a single frame" do
    score = Tenpin::Score.new

    score.roll(8)
    score.roll(1)

    expect(score.frames).to eq([[8, 1]])
    expect(score.frame_totals).to eq([9])
    expect(score.total).to eq(9)
  end

  it "bowls a spare and a bonus" do
    score = Tenpin::Score.new

    score.roll(8)
    score.roll(2) # spare
    score.roll(9) # bonus

    expect(score.frames).to eq([[8,2], [9]])
    expect(score.frame_totals).to eq([19, 28])
    expect(score.total).to eq(28)
  end

  it "bowls a strike in the 1st roll and a bonus of 2 rolls" do
    score = Tenpin::Score.new

    score.roll(10) # strike
    score.roll(8) # bonus
    score.roll(1) # bonus

    expect(score.frames).to eq([[10], [8,1]])
    expect(score.frame_totals).to eq([19, 28])
    expect(score.total).to eq(28)
  end

  it "bowls a strike in the 2nd roll and a bonus of 2 rolls" do
    score = Tenpin::Score.new

    score.roll(0)
    score.roll(10)
    score.roll(8)
    score.roll(1)

    expect(score.frames).to eq([[0, 10], [8,1]])
    expect(score.frame_totals).to eq([19, 28])
    expect(score.total).to eq(28)
  end

  it "bowls a strike in the 1st frame and a spare in the 2nd frame" do
    score = Tenpin::Score.new

    score.roll(10) # strike

    score.roll(8)
    score.roll(2) # spare

    score.roll(9)
    score.roll(0)

    expect(score.frames).to eq([[10], [8,2], [9,0]])
    expect(score.frame_totals).to eq([20, 39, 48])
    expect(score.total).to eq(48)
  end

  it "bowls a full game of 10 frames without a strike or spare" do
    score = Tenpin::Score.new

    10.times do
      score.roll(3)
      score.roll(4)
    end

    expect(score.frames).to eq(Array.new(10, [3,4]))
    expect(score.frame_totals).to eq([7, 14, 21, 28, 35, 42, 49, 56, 63, 70])
    expect(score.total).to eq(70)
  end

  it "exceeds the maximum number of rolls and throws an error" do
    score = Tenpin::Score.new

    expect {
      22.times { score.roll(1) }
    }.to raise_error(Tenpin::Score::Stopped)
  end

  it "bowls a full game of constant spares in 10 frames" do
    score = Tenpin::Score.new

    21.times { score.roll(5) }

    expect(score.frames).to eq(Array.new(9, [5, 5]) + [[5, 5, 5]])
    expect(score.frame_totals).to eq([15, 30, 45, 60, 75, 90, 105, 120, 135, 150])
    expect(score.total).to eq(150)
  end

  it "bowls a perfect score of constant strikes in 10 frames" do
    score = Tenpin::Score.new

    12.times { score.roll(10) }

    expect(score.frames).to eq(Array.new(9, [10]) + [[10, 10, 10]])
    expect(score.frame_totals).to eq([30, 60, 90, 120, 150, 180, 210, 240, 270, 300])
    expect(score.total).to eq(300)
  end
end
