
class
	ETF_NEW_GAME
inherit
	ETF_NEW_GAME_INTERFACE
create
	make
feature -- command
	new_game(a_level: INTEGER_32)
		require else
			new_game_precond(a_level)

		local

			difficulty: INTEGER
    	do
			-- perform some update on the model state
			if a_level ~ easy then
				difficulty := 1
			elseif  a_level ~ medium then
				difficulty := 2
			elseif a_level ~ hard then
				difficulty := 3
			end
			model.new_game(difficulty)

			etf_cmd_container.on_change.notify ([Current])
    	end

end
