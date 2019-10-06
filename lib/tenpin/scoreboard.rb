# frozen_string_literal: true

require_relative "entity"

module Tenpin
  class Scoreboard < Entity

    def initialize(x, y, score: nil)
      super(x, y)

      @score = score
    end

    # Draw a scoreboard with current scores
    #
    # @api public
    def draw(canvas = $stdout)
      template.lines.each.with_index do |line, i|
        canvas.print @cursor.move_to(pos.x, pos.y + i) + line
      end
    end

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
          line << frame_throw1(frame) + "|" + frame_throw2(frame) + "|" + " "
        else
          line << " " + frame_throw1(frame) + "|" + frame_throw2(frame)
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

    # @api private
    def frame_throw1(frame)
      scores = @score[frame]
      scores.nil? ? "  " : scores[0].to_s.rjust(2)
    end

    # @api private
    def frame_throw2(frame)
      scores = @score[frame]
      if scores.nil?
        " "
      elsif scores[0] == 10
        "x"
      elsif scores[0].to_i + scores[1].to_i == 10
        "\\"
      else
        scores[1].to_s.rjust(1)
      end
    end

    # @api private
    def frame_total(frame)
      width = (frame == 9 ? 6 : 5)
      if @score[frame].nil?
        return " " * width
      end

      (@score[frame][0].to_i + @score[frame][1].to_i).to_s.rjust(width)
    end
  end # Scoreboard
end # Tenpin
