

class
	ETF_SOLVE
inherit
	ETF_SOLVE_INTERFACE
create
	make
feature -- command
	solve
    	do
			-- perform some update on the model state
			model.default_update
			etf_cmd_container.on_change.notify ([Current])
    	end

end
