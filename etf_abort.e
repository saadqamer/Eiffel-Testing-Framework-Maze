
class
	ETF_ABORT
inherit
	ETF_ABORT_INTERFACE
create
	make
feature -- command
	abort
    	do
			-- perform some update on the model state
			model.abort
			etf_cmd_container.on_change.notify ([Current])
    	end

end
