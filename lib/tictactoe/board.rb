module TicTacToe
  class Board

    BOARD_SIZE = 9
    ROW_SIZE = 3

    def initialize
      @positions = Array.new(BOARD_SIZE)
    end

    def add_move(mark, position)
      positions[position] = mark
    end

    def move_valid?(position)
      position_within_board_range(position) and position_is_empty?(position)
    end

    def won?
      winning_line_exists?
    end

    def draw?
      !winning_line_exists? && board_full?
    end

    def get_mark_at_position(position)
      positions[position]
    end

    def total_moves_made
      positions.count{ |position| !position.nil? }
    end

    private

    def winning_line_exists?
      !find_winning_line(winning_lines).nil?
    end

    def find_winning_line(lines)
      lines.find {|line| line_has_same_mark?(line) }
    end

    def line_has_same_mark?(line)
      line.all?{ |mark| mark == line[0] && !mark.nil? }
    end

    def winning_lines
      rows + cols + diagonals
    end

    def cols
      rows.transpose
    end

    def rows
      positions.each_slice(ROW_SIZE).to_a
    end

    def diagonals
      [diagonal_top_left, diagonal_top_right]
    end

    def diagonal_top_left
      rows.collect.with_index do |row, index|
        row[index]
      end
    end

    def diagonal_top_right
      rows.collect.with_index do |row, index|
        row.reverse[index]
      end
    end

    def board_full?
      positions.none? { |position| position.nil? }
    end

    def position_within_board_range(position)
      position >= 0 and position < BOARD_SIZE
    end

    def position_is_empty?(position)
      positions[position].nil?
    end

    attr_reader :positions
  end
end
