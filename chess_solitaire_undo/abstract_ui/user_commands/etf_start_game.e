note
	description: ""
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ETF_START_GAME
inherit
	ETF_START_GAME_INTERFACE
create
	make
feature -- command
	start_game
    	do
			-- perform some update on the model state
			if
				model.op_cursor<model.operations.count
			then
				model.rm_pre_ops
			end
			if
				model.started = false
			then
			    model.start_game
			else
				model.already_not_started_error(True)
			end

			etf_cmd_container.on_change.notify ([Current])
    	end

end
