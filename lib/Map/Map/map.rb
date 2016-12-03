class Map

	# @param [Hash] params the parameters for creating a Map.
	# @option params [String] :name the name.
	# @option params [[Tile]] :tiles the content of the map.
	# @option params [Couple(Int,Int)] :regen_location the respawn-on-death coordinates.
	def initialize(params = {})
		@name = params[:name] || "Map"
		@tiles = params[:tiles] || [ [Tile.new ] ]
		@regen_location = params[:regen_location] || Couple.new(0,0)
		@music = false
	end
	
	def play_music(bool)
		@music = bool

		_relativePATH = File.expand_path File.dirname(__FILE__)

		if @music === true

			$pid = Process.spawn "while true; do afplay #{_relativePATH}/intro.mp3; done"

		elsif @music === false
			# Use sleep for testing music off.  Music will continue to play until it hits the end of track
			# sleep(15)
			Process.kill(15, $pid)
		else
			p "Please enter a true or false parameter"
		end
	end

	# @param [Map] rhs the map on the right.
	def ==(rhs)
		return @name == rhs.name
	end

  # Prints the map in a nice format.
	def to_s
		output = ""
    @tiles.each do |row|
      row.each do |tile|
        output += (tile.graphic + " ")
      end
			output += "\n"
    end
		return output
  end

	# Returns true when @tiles[y][x] is an existing index of @tiles.
	# Otherwise, returns false.
	#
	# @param [Integer] y the y-coordinate.
	# @param [Integer] x the x-coordinate.
	# @return [Boolean] the existence of the tile.
	def in_bounds(y, x)
		return (y >= 0 && y < @tiles.length && x >= 0 && x < @tiles[y].length)
	end

	attr_accessor :name, :tiles, :regen_location, :music

end

# For manually testing this individual file (will need to comment out @tiles &@regen_locations in initialize)
# @map = Map.new
# @map.play_music(true)
# @map.play_music(false)