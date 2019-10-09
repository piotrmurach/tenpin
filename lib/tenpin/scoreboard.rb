# frozen_string_literal: true

require_relative "entity"

module Tenpin
  class Scoreboard < Entity

    def initialize(x, y, scores: [], totals: [])
      super(x, y)

      @scores = scores
      @totals = totals
    end

    # Draw a scoreboard with current scores
    #
    # @api public
    def draw(canvas = $stdout)
      template.lines.each_with_index do |line, i|
        canvas.print @cursor.move_to(pos.x, pos.y + i) + line
      end
    end

    private

    # The score template
    #
    # @return [String]
    #
    # @api private
    def template
      <<-BOARD
 _____________________________
|__1__|__2__|__3__|__4__|__5__|
|#{score_line(0..4).join("|")}|
|#{total_line(0..4).join("|")}|
|_____|_____|_____|_____|_____|
 ______________________________
|__6__|__7__|__8__|__9__|__10__|
|#{score_line(5..9).join("|")}|
|#{total_line(5..9).join("|")}|
|_____|_____|_____|_____|______|
      BOARD
    end

    # A line of scores for given frames
    #
    # @param [Range] frames
    #   the range of frames to display scores
    #
    # @return [Array[String]]
    #
    # @api private
    def score_line(frames)
      frames.reduce([]) do |line, frame|
        if frame == 9
          line << "#{first_roll(frame)}|#{second_roll(frame)}|#{third_roll(frame)}"
        else
          line << " #{first_roll(frame)}|#{second_roll(frame)}"
        end
        line
      end
    end

    # A line of total scores for given frames
    #
    # @param [Range] frames
    #   the range of frames to display scores
    #
    # @return [Array[String]]
    #
    # @api private
    def total_line(frames)
      frames.reduce([]) do |acc, frame|
        acc << frame_total(frame)
        acc
      end
    end

    # Marks 1st roll on the board
    #
    # @return [String]
    #
    # @api private
    def first_roll(frame)
      scores = @scores[frame]
      if scores.nil? || strike?(frame)
        "  "
      elsif scores[0].to_i == 0
        " -"
      else
        scores[0].to_s.rjust(2)
      end
    end

    # Marsk 2nd roll on the board
    #
    # Following symbols signify:
    #
    # x - a strike
    # / - a spare
    # - - no pins knocked down
    #
    # @return [String]
    #
    # @api private
    def second_roll(frame)
      scores = @scores[frame]
      if scores.nil?
        " "
      elsif strike?(frame)
        "x"
      elsif spare?(frame)
        "/"
      elsif scores[1].to_i == 0
        "-"
      else
        scores[1].to_s
      end
    end

    # Mark 3rd roll on the board
    #
    # @api private
    def third_roll(frame)
      scores = @scores[frame]
      scores.nil? ? " " : (scores[2] || " ")
    end

    # Check frame for strike
    #
    # @api private
    def strike?(frame)
      scores = @scores[frame]
      return false if scores.nil?

      scores[0].to_i == 10 || scores[1].to_i == 10
    end

    # Check frame for spare
    #
    # @api private
    def spare?(frame)
      scores = @scores[frame]
      return false if scores.nil?

      (scores[0].to_i != 10) && (scores[0].to_i + scores[1].to_i == 10)
    end

    # Display frame total
    #
    # @api private
    def frame_total(frame)
      width = (frame == 9 ? 6 : 5)
      (@totals[frame] || " ").to_s.rjust(width)
    end
  end # Scoreboard
end # Tenpin