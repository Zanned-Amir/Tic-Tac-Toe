module Display
  attr_reader :score, :name,:winner

  def notice
    puts "\nchoose a place based on columns and rows !"
  end

  def start
    puts "\nbeginning of the game : ) "
  end
   
  def turn
    puts "\nyour turn #{self.name}"
  end

  def game_end
    puts "\nwinner is #{self.winner}"
  end
end

class User

  def initialize(name)
    @name = name
    puts "\nWelcome #{@name}"
  end
end

class Player < User
  attr_accessor :score, :name, :symbol

  def initialize(name, symbol)

    super(name)
    @symbol = symbol
    puts "you choosed #{symbol}"
    @score =0

  end

  include Display


  def show_symbol

    puts "#{self.name} you choose #{self.symbol}"
  end

  def set_score(_s)

    self.score +=1
  end

  def show_score

    puts "#{self.name} your score is #{self.score}"
  end
end

class Board
  attr_accessor :matrix

  def initialize
    @matrix = Array.new(3) { Array.new(3, " ") }
  end
  def update_board(row,column,symbol)

    self.matrix[row][column]=symbol

  end

  def reset

    (0...3).each do |i|
      (0...3).each do |j|
       self.matrix[i][j]=" "
      end
    end

  end

  def show_board

    puts "\n   0   1   2"
    puts "  -------------"
    (0...3).each do |i|
      print "#{i} |"
      (0...3).each do |j|
        print " #{self.matrix[i][j]} |"
      end
      puts "\n  -------------"
    end

  end

end

class Game

  attr_accessor :board, :player1, :symbol1, :player2, :symbol2
  attr_reader :winner

  def initialize(board, player1, symbol1, player2, symbol2)
    @winner="None"
    @board = board
    @player1 = player1
    @symbol1 = symbol1
    @player2 = player2
    @symbol2 = symbol2
  end

  include Display
  def set_winner(w)
    @winner =w
  end
  
  def check_win(symbol)
    # Check rows and columns
    (0...3).each do |i|
      return true if board.matrix[i].all? { |cell| cell == symbol } || (0...3).all? { |j| board.matrix[j][i] == symbol }

    end
    # Check diagonals
    return true if (0...3).all? { |k| board.matrix[k][k] == symbol } || (0...3).all? { |k| board.matrix[k][2 - k] == symbol }

    false
  end
  def check_eqaul
    (0...3).each do |i|
      return true if board.matrix[i].all? { |cell| cell != " " } && (0...3).all? { |j| board.matrix[j][i] !=" " }
    end
  end


  def check_input(row ,column)

    return true if  (0..2).include?(row.to_i) && (0..2).include?(column.to_i) && board.matrix[row][column]==" "

    false
  end

end


board = Board.new
name = ""
symbol = ""
name2 = ""
r2=0
c2=0
r=0
c=0
answer=""

loop do
  puts "Give your name player 1 :"
  name = gets.chomp()

  puts "Choose Symbol X or O:"
  symbol = gets.chomp().upcase

  break if (symbol == "X" || symbol == "O") && !name.empty?
end

player1 = Player.new(name, symbol)

loop do
  puts "Give your name player 2 :"
  name2 = gets.chomp()

  break if !name2.empty?
end
choice=  (symbol=="X") ?    "O"  : "X"
player2 = Player.new(name2,choice )
game =Game.new(board,player1.name,player1.symbol,player2.name,player2.symbol)
game.start
puts player2.symbol
puts player1.symbol
loop do
  board.reset
  player1.turn
  board.show_board
loop do
  begin

    loop do
      player1.notice

      puts "row :"
      r=gets.chomp.to_i

      puts "column :"
      c=gets.chomp.to_i
    
      break if game.check_input(r, c) ==true
    end
  
    board.update_board(r,c,player1.symbol)
    board.show_board
    if game.check_win(player1.symbol) == true
      
      game.set_winner(player1.name)
      player1.set_score(1)
      raise "win"
      
    end

  

  player2.turn

    loop do
      player2.notice

      puts "row :"
      r2=gets.chomp.to_i

      puts "column :"
      c2=gets.chomp.to_i
    
     break if game.check_input(r2, c2) ==true
    end
  
  board.update_board(r2,c2,player2.symbol)
  board.show_board
  if game.check_win(player2.symbol) == true
      
    game.set_winner(player2.name)
    player2.set_score(1)
    raise "win"
    
  end
  rescue
    puts "end game \n"
  end
  
break if game.winner !="None" || game.check_eqaul == true
end
game.game_end
player1.show_score
player2.show_score
puts "wanna replay"

answer = gets.chomp.upcase

break if !answer.include?("YES")
end
