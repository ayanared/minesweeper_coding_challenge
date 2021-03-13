def play_game(rows, columns, num_of_bombs)
  # create board
  num_of_cells = rows * columns;
  # place mines
  # find num_of_bomb places to place bombs
  prng = Random.new
  array_of_places = num_of_bombs.times.map do |place| 
    prng.rand(1..num_of_cells)
  end

  # put bombs in board
  game_board = 
    (0...rows).map do |row|
      (0...columns).map do |column|
          cell_number = column + 1 + (columns * row)
          if array_of_places.include?(cell_number)
            is_bomb = true
          else
            is_bomb = false
          end
          {cell_number: cell_number,
           bomb: is_bomb,
           row: row,
           column: column
           }
          
      end
    end
    flat_game_board = game_board.flatten
    flat_game_board.map.with_index do |cell, i|
      num_of_adjacent_bombs = 0
      #check above (cell position - num_of_columns)
      if (i - columns + 1) >= 0 && flat_game_board[i - columns][:bomb]
        flat_game_board[i][:top_bomb] = 1
        num_of_adjacent_bombs += 1
      end
      #check to the right(cell position + 1 if cell % num_of_columns != 0)
      if flat_game_board[i + 1] && (i + 1) % columns != 0 && flat_game_board[i + 1][:bomb]
        flat_game_board[i][:right_bomb] = 1
        num_of_adjacent_bombs = num_of_adjacent_bombs + 1
      end
      #check to the left (cell position - 1 if cell % num_of_rows != 1)
      if (i - 1) >= 0 && (i + 1) % rows != 1 && flat_game_board[i - 1][:bomb]
        flat_game_board[i][:left_bomb] = 1
        num_of_adjacent_bombs = num_of_adjacent_bombs + 1
      end
      #check bottom (cell position + num_of_rows)
      if flat_game_board[i + columns] && flat_game_board[i + columns][:bomb]
        flat_game_board[i][:bottom_bomb] = 1
        num_of_adjacent_bombs =  num_of_adjacent_bombs + 1
      end
      #check top left diagonal
      #check top right diagonal
      #check bottom left diagonal
      #check bottom right diagonal
      flat_game_board[i][:adjacent_bombs] = num_of_adjacent_bombs
    end
    flat_game_board
end

def printboard (game_board, rows, columns)
  board_string = ''
  game_board.each do |cell|  
    if cell[:bomb]
      board_string += '*'
    elsif cell[:cell_number] % rows == 1
      board_string += "\n #{cell[:adjacent_bombs]}"
    else
      board_string += "#{cell[:adjacent_bombs]}"
    end
  end
  board_string
end
board = play_game(4,4,2)
puts board
puts printboard(board, 4, 4)