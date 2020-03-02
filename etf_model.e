note
	description: "A default business model."
	author: "Jackie Wang"
	date: "$Date$"
	revision: "$Revision$"

class
	ETF_MODEL

inherit
	ANY
		redefine
			out
		end

create {ETF_MODEL_ACCESS}
	make

feature {NONE} -- Initialization
	make
			-- Initialization for `Current'.
		do
			create s.make_empty

			create maze_generator.make
			create maze_graph.make_empty
			maze_graph := maze_generator.generate_new_maze (1)
			current_row := 1
			current_col := 1
			create maze_drawer.make (maze_graph)
			maze_drawer.init_player
			create og_coordinate.make ([current_row, current_col])
			create new_coordinate.make ([current_row, current_col])
			create source.make (og_coordinate)
			create destination.make (new_coordinate)
			create s_d_edge.make (destination, source)
			game_won := false


			i := 0
		end

feature -- model attributes
	s : STRING
	i : INTEGER
	maze_generator: MAZE_GENERATOR
	maze_drawer: MAZE_DRAWER
	maze_graph: LIST_GRAPH[COORDINATE]
	game_number: INTEGER
	score: INTEGER
	total_possible_score: INTEGER
	aborted: BOOLEAN

	og_coordinate: COORDINATE
	new_coordinate: COORDINATE
	source: VERTEX[COORDINATE]
	destination: VERTEX[COORDINATE]
	s_d_edge: EDGE[COORDINATE]

	current_row: INTEGER
	current_col: INTEGER

	game_won: BOOLEAN
	score_earned: INTEGER




feature -- model operations
	default_update
			-- Perform update to the model state.
		do
			i := i + 1
		end

	reset
			-- Reset model state.
		do
			make
		end

	abort
		do
			aborted := true
		end

	new_game(level: INTEGER_32)
		do
			create maze_generator.make
			maze_graph := maze_generator.generate_new_maze (level)
			create maze_drawer.make (maze_graph)
			maze_drawer.init_player
			game_number := game_number + 1
			i := i + 1
			if level ~ 1 then
				score_earned := 1
				total_possible_score := total_possible_score + 1
			end
			if level ~ 2 then
				score_earned := 2
				total_possible_score := total_possible_score + 2
			end
			if level ~ 3 then
				score_earned := 3
				total_possible_score := total_possible_score + 3
			end

		end

	move(direction: TUPLE[row: INTEGER; col: INTEGER])
		do
			i := i + 1

			create new_coordinate.make ([current_row + direction.row, current_col + direction.col])
			create source.make ([current_row, current_col])
			create destination.make ([current_row + direction.row, current_col + direction.col])
			create s_d_edge.make (source, destination)

			if maze_graph.has_edge (s_d_edge) or maze_graph.has_edge (s_d_edge.reverse_edge) then
				maze_drawer.move_player (direction)
				current_row := destination.item.row
				current_col := destination.item.col
				if current_row = maze_drawer.size and current_col = maze_drawer.size then
					game_won := true
					score := score_earned
				end

			end



--			across
--				maze_graph.vertices as v
--			loop
--				if v.item.has_outgoing_edge (s_d_edge) or v.item.has_incoming_edge (s_d_edge.reverse_edge) then
--					maze_drawer.move_player (direction)
--					create og_coordinate.make ([new_coordinate.row, new_coordinate.col])
--				end
--			end

		end

feature -- queries
	out : STRING
		do
			create Result.make_from_string ("")

			if i = 0 or aborted then
				Result.append ("  State: ")
				Result.append (i.out)
				Result.append (" -> ok")
			end
			if i > 0 and game_won ~ false then
				Result.append ("  State: ")
				Result.append (i.out)
				Result.append (" -> ok")
				Result.append(maze_drawer.out)
				Result.append("  %N  Game Number: ")
				Result.append(game_number.out)
				Result.append("  %N  Score: ")
				Result.append (score.out)
				Result.append ("/")
				Result.append (total_possible_score.out)
				Result.append ("%N")
			end
			if i > 0 and game_won ~ true then
				Result.append ("  State: ")
				Result.append (i.out)
				Result.append (" -> ok")
				Result.append(maze_drawer.out)
				Result.append("  %N  Congratulations! You escaped the maze! ")
				Result.append("  %N  Game Number: ")
				Result.append(game_number.out)
				Result.append("  %N  Score: ")
				Result.append (score.out)
				Result.append ("/")
				Result.append (total_possible_score.out)
				Result.append ("%N")
			end

--				Result.append(og_coordinate.row.out)
--				Result.append(og_coordinate.col.out)
--				Result.append(new_coordinate.row.out)
--				Result.append(new_coordinate.col.out)
--				Result.append (source.out)
--				Result.append (destination.out)
--				across
--					maze_graph.vertices as v
--				loop
--					across
--						v.item.outgoing as o
--					loop
--						Result.append("source:")
--						Result.append(o.item.source.item.out)
--						Result.append("destination")
--						Result.append(o.item.destination.item.out)
--					end
--				end



		end

end







