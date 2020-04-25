
class
	ETF_MOVE
inherit
	ETF_MOVE_INTERFACE
create
	make
feature -- command
	move(a_direction: INTEGER_32)
		require else
			move_precond(a_direction)
		local
			d_u: DIRECTION_UTILITY
    	do
			-- perform some update on the model state

			if a_direction ~ N then
				model.move (d_u.n)
			end
			if a_direction ~ S then
				model.move (d_u.s)
			end
			if a_direction ~ E then
				model.move (d_u.e)
			end
			if a_direction ~ W then
				model.move (d_u.w)
			end

			etf_cmd_container.on_change.notify ([Current])
    	end

end
