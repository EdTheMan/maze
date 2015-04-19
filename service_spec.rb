  require_relative './maze'
  require 'rspec'
  require 'rack/test'
  #require 'rspec'
  #require 'rack/test'


  describe "maze" do 
    include Rack::Test::Methods
    describe "New maze" do

      it "Should be a valid maze" do

        test = Maze.new(9,9)
        test.load("111111111100010001111010101100010101101110101100000101111011101100000101111111111")
        
        test.valid?.should == true

      end

      describe "Should not be a valid maze," do

        it "loaded with bad string" do
          test = Maze.new(9,9)
          test.load("1111111111000100011110101011000101011011101011000001011110111011000001011111111")

          test.valid?.should == false
        end

        it "maze not loaded" do
          test = Maze.new(9,9)

          test.valid?.should == false
        end

      end

      describe "test methods," do

        before (:each) do
          @test = Maze.new(9,9)
          @test.load("111111111100010001111010101100010101101110101100000101111011101100000101111111111")
        end

        it "should trace correctly" do
          
          expect { @test.trace(1,1,1,5) }.to output("1 1\n2 1\n3 1\n3 2\n3 3\n2 3\n1 3\n1 4\n1 5\n").to_stdout
        end

        it "should return true using solve" do

          @test.solve(2,1,1,5).should == true

        end

        it "should return false using solve" do

          @test.solve(2,1,6,8).should_not == true

        end

      end

    end

  end