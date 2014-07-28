class HugeDrawingTool

	def initialize
		@canvas = [[]];
		@init = false
	end

	def read_input
		while true
			print_menu
			input = gets.chomp
			break if input == "Q"

			handle_input(input.split(" "))
			draw_canvas
			puts ""
		end
		puts "Have a nice day!"
	end

	private
	def handle_input(input)
		command = input[0]
		coords = input.drop(1).map(&:to_i)

		# check if coordinates are on the canvas
		if @init == true && command != "C" && command != "B"
			if !check_coords(coords)
				puts "Please enter valid coordinates."
				return
			end
		elsif @init == true && command == "B"
			if !check_coords(coords, true)
				puts "Please enter valid coordinates."
				return
			end
		end

		if command == "C"
			create_canvas(coords)
		elsif command == "L"
			draw_line(coords)
		elsif command == "R"
			draw_rectangle(coords)
		elsif command == "B"
			fill_area(input.drop(1))
		else
			puts "Error: Unidentified command. Please try again."	
		end
	end

	def check_coords(coords, fill = false)
		height = @canvas.length - 2
		width = @canvas[0].length - 2

		if fill
			if coords.length < 3
				return false
			elsif coords[1] > height || coords[1] < 0 || coords[0] > width || coords[0] < 0
				return false
			end

			return true
		end

		return false if coords.any? { |coord| coord <= 0 } || coords.length < 4

		if coords[1] > height || coords[3] > height || coords[0] > width || coords[2] > width
			return false
		end

		return true
	end

	def create_canvas(coord)
		@init, width, height = true, coord[0], coord[1]
		@canvas = Array.new(height + 2) { Array.new() }

		(height + 2).times do |i|
			(width + 2).times do |j|
				if i == 0 || i == height + 1
					@canvas[i][j] = "-"
				elsif j == 0 || j == width + 1
					@canvas[i][j] = "|"
				else
					@canvas[i][j] = " "
				end
			end
		end
	end

	def draw_line(coord)
		if @init == false
			puts "Must create a canvas first."
			return
		end

		if coord[0] == coord[2]
			draw_vertical_line(coord)
		elsif coord[1] == coord[3]
			draw_horizontal_line(coord)
		else
			puts "Unable to draw diagonal lines. Please insert vertical or horizontal coordinates only."
			return
		end

	end

	def draw_horizontal_line(coord)
		y, x1, x2 = coord[1], coord[0], coord[2]

		x1.upto(x2) do |col|
			@canvas[y][col] = "x"
		end
	end

	def draw_vertical_line(coord)
		x, y1, y2 = coord[0], coord[1], coord[3]

		y1.upto(y2) do |row|
			@canvas[row][x] = "x"
		end
	end

	def draw_rectangle(coord)
		if @init == false
			puts "Must create a canvas first." 
			return
		end

		x1, x2, y1, y2 = coord[0], coord[2], coord[1], coord[3]

		draw_horizontal_line([x1, y1, x2])
		draw_horizontal_line([x1, y2, x2])
		draw_vertical_line([x1, y1, x2, y2])
		draw_vertical_line([x2, y1, x1, y2])
	end

	def fill_area(coord)
		if @init == false
			puts "Must create a canvas first." 
			return
		end

		x, y, color  = coord[0].to_i, coord[1].to_i, coord[2]
		if @canvas[y][x] == "x" || @canvas[y][x] == "|" || @canvas[y][x] == "-" || @canvas[y][x] == color
			return
		else
			@canvas[y][x] = color
			fill_area([x - 1, y, color])
			fill_area([x + 1, y, color])
			fill_area([x, y - 1, color])
			fill_area([x, y + 1, color])
		end
	end

	def print_menu
		puts "\nENTER A COMMAND: \n\n"
		puts "'C w h' --------- Creates a new canvas of width 'w' and height 'h.'\n\n"
		puts "'L x1 y1 x2 y2' - Creates a new line from (x1, y1) to (x2, y2).\n\n"
		puts "'R x1 y1 x2 y2' - Creates a rectangle with upper left corner (x1, y1)"
		puts " 		- and bottom right corner (x2, y2).\n\n"
		puts "'B x y c' ------- Fills the entire area connect to (x, y) with color 'c.'\n\n"
		puts "'Q' ------------- Quits the program.\n\n"
		puts "-------------------------------------------------------------------------------\n\n"
	end

	def draw_canvas
		@canvas.each do |row|
			print row.join("")
			print "\n"
		end
	end
end