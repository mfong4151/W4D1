require_relative 'tic_tac_toe'

class TicTacToeNode

  attr_reader :board, :next_mover_mark, :prev_move_pos
  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board
    @next_mover_mark = next_mover_mark #symbol :x :o
    @prev_move_pos = prev_move_pos
  end

  def losing_node?(evaluator)
  end

  def winning_node?(evaluator)
  end

  # This method generates an array of all moves that can be made after
  # the current move.
  def children
    
    if @next_mover_mark == :x
      nxt = :o
    else
      nxt = :x
    end
    res = []
    (0..2).each do |row|
      (0..2).each do |col|
        pos = [row, col]
        if @board.empty?(pos)
          new_board = @board.dup
          new_board[pos] = self.next_mover_mark
          res << TicTacToeNode.new(new_board, nxt, pos)
        end
      end
    end

    return res
  end

  def losing_node?(evaluator) #going to be a symbol, :x or :o
    if @board.over? && (@board.winner == nil || @board.winner == evaluator)
        return false
    elsif @board.over? && (@board.winner != evaluator)
        return true
    end

    if evaluator == @next_mover_mark
      self.children.all?{|child| child.losing_node?(evaluator)}
    elsif evaluator != @next_mover_mark
      self.children.any?{|child| child.losing_node?(evaluator)}
    elsif @board.over? && @board.tied?
      return false
    end
    
  end  

  def winning_node?(evaluator) #going to be a symbol, :x or :o
 
    
    if (@board.over? && (@board.winner == evaluator && evaluator != @next_mover_mark)) || (@board.won? && evaluator == @next_mover_mark)
        return true
    elsif @board.over? && (@board.winner == nil || @board.winner == @next_mover_mark)
        return false
    end

    if evaluator != @next_mover_mark
      self.children.all?{|child| child.winning_node?(evaluator)}
    elsif evaluator == @next_mover_mark
      self.children.any?{|child| child.winning_node?(evaluator)}
    elsif @board.over? && @board.tied?
      return true
    end
    
  end  

end

# A #losing_node? is described in the following cases:

# Base case: the board is over AND
# If winner is the opponent, this is a losing node.
# If winner is nil or us, this is not a losing node.
# Recursive case:
# It is the player's turn, and all the children nodes are losers for the player (anywhere they move they still lose), OR
# It is the opponent's turn, and one of the children nodes is a losing node for the player (assumes your opponent plays perfectly; they'll force you to lose if they can).
