# frozen_string_literal: true

module Tenpin
  class Score
    MAX_FRAMES_INDEX = 9

    Stopped = Class.new(StandardError)

    # The current total score
    attr_reader :total

    # The recording of all scores in each frame
    attr_reader :frames

    # Holds all the frame totals
    attr_reader :frame_totals

    # The currenty played frame 0 indexed
    attr_reader :current_frame

    # Create a game score
    #
    # @api public
    def initialize
      @total = 0
      @current_frame = 0
      @frames = []
      @frame_totals = []
    end

    # Current frame scores
    #
    # @return [Array[Integer]]
    #
    # @api public
    def current_frame_scores
      @frames[current_frame] ||= []
    end

    # Record how many pins knocked down in a single roll
    #
    # @param [Integer] pins
    #   the number of pins knocked down
    #
    # @api public
    def roll(pins)
      return if finish?

      current_frame_scores << pins
      @total += pins

      # Calculate bonus
      if (!last_roll? && previous_frame_strike?) ||
         (first_roll? && previous_frame_spare?)
        @total += pins
        @frame_totals[current_frame - 1] += pins
      end

      if first_roll? && previous_two_frames_strike?
        @total += pins
        @frame_totals[current_frame - 1] += pins
        @frame_totals[current_frame - 2] += pins
      end

      @frame_totals[current_frame] = @total

      if next_frame?
        @current_frame += 1
        yield if block_given?
      end
    end

    # Check if game is finished
    #
    # @return [Boolean]
    #
    # @api public
    def finish?
      last_frame? && (last_roll? ||
        (second_roll? && !(strike?(current_frame) || spare?(current_frame))))
    end

    private

    def next_frame?
      (strike?(current_frame) || spare?(current_frame) || second_roll?) && !last_frame?
    end

    def last_frame?
      current_frame == MAX_FRAMES_INDEX
    end

    def previous_two_frames_strike?
      previous_frame_strike? && current_frame > 1 && strike?(current_frame - 2)
    end

    def previous_frame_strike?
      strike?(current_frame - 1) && current_frame > 0
    end

    def strike?(frame)
      roll_first(frame) == 10
    end

    def previous_frame_spare?
      spare?(current_frame - 1) && current_frame > 0
    end

    def spare?(frame)
      (roll_first(frame) != 10) && (roll_first(frame) + roll_second(frame) == 10)
    end

    def first_roll?
      !current_frame_scores[0].nil? && current_frame_scores[1].nil?
    end

    def roll_first(frame)
      @frames[frame][0].to_i
    end

    def second_roll?
      !current_frame_scores[1].nil?
    end

    def roll_second(frame)
      @frames[frame][1].to_i
    end

    def last_roll?
      !current_frame_scores[2].nil?
    end
  end # Score
end # Tenpin
