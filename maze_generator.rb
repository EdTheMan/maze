#Chi Ieong Tai
#COSI 105b
#Attempt at randomly generating maze using backtrack algorthim
#class does not work. Could not finish.

class MazeGenerator
  
  def initialize(n,m)
    
    @maze = Array.new (n) { Array.new (m) }
    arg = "1" * (n*m)
    @maze = arg.split("").each_slice(n).to_a 
    @n = n
    @m = m
    @maze_track = Array.new (n) { Array.new (m) }
    @point = Struct.new(:x, :y, :previousPoint)
    
    @maze.each_with_index do |y, index|
      
    
        y.each_with_index do |x, index2|
        
        
        if(index == 0 || index == (m-1) || index2 == 0 || index2 == (n-1))
        @maze[index][index2] = 2
        
        end
        
      end
      
    end 
    
    #p @maze
  end
  
  def display
    
    @maze.each do |key|
      
      key.each do |key2|
      print key2
      end
      
      puts 
      
    end
    
  end
 

  def generate_maze
    
    x = 1
    
    prng = Random.new
    start_x = prng.rand(1..(@n-2))
    start_y = prng.rand(1..(@m-2))
    
    starting_point = @point.new(-1,-1,@point.new(-1,-1))
    finished_point = @point.new(start_x,start_y,@point.new(0,0))
    
    while ((starting_point.x != finished_point.x) || (starting_point.y != finished_point.y)) do

      if(x==1)
        starting_point = finished_point
        @maze[starting_point.y][starting_point.x] = 0
        @maze_track[starting_point.y][starting_point.x] = 1
        x = x + 1
      end
      
      point = get_solutions(starting_point)
   
   
      if(point != 0 && (@maze_track[point.y][point.x] !=1))
         
        @maze[point.y][point.x] = 0
        @maze_track[point.y][point.x] = 1
        
        starting_point = @point.new(point.x,point.y,starting_point)
        
      else
        starting_point = starting_point.previousPoint

      end
      
      display()
      puts 
            
    end
    
  end
  
  def get_solutions(point)

    x = point.x
    y = point.y
    
    #left
    if(@maze[y][x-1] == "1")
      return @point.new(x-1,y)
    end
    #right
    if(@maze[y][x+1] == "1")
      return @point.new(x+1,y)
    end
    #top
    if(@maze[y+1][x] == "1")
      return @point.new(x,y+1)
    end
    #down
    if(@maze[y-1][x] == "1")
      return @point.new(x,y-1)
    end
    
    return 0
  end
  
end

test = MazeGenerator.new(9,9)

#test.display()

test.generate_maze()
