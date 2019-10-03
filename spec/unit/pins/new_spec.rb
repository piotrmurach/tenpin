# frozen_string_literal: true

RSpec.describe Tenpin::Pins, "#new" do
  it "initilizes default pins layout" do
    pins = Tenpin::Pins.new(0, 0)

    expect(pins.pins.map(&:pos).map(&:to_a)).to eq([
      [3,0], [7,0], [11,0], [15,0],
      [5,1], [9,1], [13,1],
      [7,2], [11,2],
      [9,3]
    ])
  end

  it "initilizes pins layout to a position" do
    pins = Tenpin::Pins.new(3, 4)

    expect(pins.pins.map(&:pos).map(&:to_a)).to eq([
      [6,4], [10,4], [14,4], [18,4],
      [8,5], [12,5], [16,5],
      [10,6], [14,6],
      [12,7]
    ])
  end
end
