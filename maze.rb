#Chi Ieong (Eddie) Tai
#COSI 105B PA(Mazes)
#maze.rb allows one to create a maze of zeros and ones
#and find a possible solution to that maze. Removed comments.


class Maze

  #initialize maze,size of maze n by m, a node, and a point representing 
  #a coordinate within the maze
  def initialize(n,m)

  	@maze = Array.new (n) { Array.new (m) }
  	@n = n
  	@m = m
  	@node = Struct.new(:parent, :value)
  	@point = Struct.new(:x, :y)

  end

  def load (arg)

  	@maze = arg.split("").each_slice(@n).to_a 

  end

  def valid?

    dummy = 0
    @maze.each do |row|
      if row.length != @m || row.include?(nil)
        dummy += 1
      end
    end
    p dummy
    return (dummy == 0) && (@maze.length == @m)


  end

  def display
  	@maze.each do |key|
  		key.each do |key2|
  			print key2
  		end

  		puts 
  	end 
  end

  def solve(begX,begY,endX,endY)
  	if(begX > 0 && begY > 0 && endX < 8 && endY < 8)
  		perform_bfs(begX,begY,endX,endY,false)
  	else
  		p "Out of range coordinates given"
  	end
  end
  
  def trace(begX,begY,endX,endY)
  	if(begX > 0 && begY > 0 && endX < 8 && endY < 8)
  		perform_bfs(begX,begY,endX,endY,true)
  	else
  		p "Out of range coordinates given"
  	end
  end
  
  def perform_bfs(begX,begY,endX,endY,do_trace)
  	queue = Queue.new
  	final_point = @point.new(endX,endY)
  	initial_node = @node.new(@node.new(nil,@point.new(-1,-1)),@point.new(begX,begY))
  	queue.push(initial_node)
  	while (not queue.empty?) do
  		value = queue.deq
  		if value.value == final_point 
  			if do_trace
  				print_tree(value)
  				return
      else
        return true
      end
    else
     solutions = get_solutions(value)
     solutions.each do |value2|
      queue.push(value2)
    end
  end
end
return "Error"
end


def print_tree(value)
 track = Array.new
 track << value.value        
 a = value
 while(a.parent.value.x != -1 && a.parent.value.y != -1) do
  track << a.parent.value
  a = a.parent
end
track.reverse.each do |value2| 
  print value2.x
  print " "
  p value2.y
end
end 


def get_solutions(node)
 solutions = Array.new
 x = node.value.x
 y = node.value.y    
    #check left of coordinate
    if (x-1 >= 0) && ((x-1) != node.parent.value.x || y != node.parent.value.y) && (@maze[y][x-1] == "0") 
    	solutions << @node.new(node,@point.new(x-1,y))
    end
    #top
    if (y-1 >= 0) && (x != node.parent.value.x || (y-1) != node.parent.value.y) && (@maze[y-1][x] == "0" )
    	solutions << @node.new(node,@point.new(x,y-1))
    end
    #right
    if (x+1 <= (@n-1)) && ((x+1) != node.parent.value.x || y != node.parent.value.y) && (@maze[y][x+1] == "0") 
    	solutions << @node.new(node,@point.new(x+1,y))
    end
    #down
    if (y+1 <= (@m-1)) && (x != node.parent.value.x || (y+1) != node.parent.value.y) && (@maze[y+1][x] == "0")
    	solutions << @node.new(node,@point.new(x,y+1))
    end
    return solutions    
  end

end

#test = Maze.new(9,9)
#test.load("111111111100010001111010101100010101101110101100000101111011101100000101111111111")
#test.trace(2,1,1,5)

#p test.valid?
