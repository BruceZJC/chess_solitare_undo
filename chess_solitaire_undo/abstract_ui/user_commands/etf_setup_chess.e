note
	description: ""
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ETF_SETUP_CHESS
inherit
	ETF_SETUP_CHESS_INTERFACE
create
	make
feature -- command
	setup_chess(c: INTEGER_32 ; row: INTEGER_32 ; col: INTEGER_32)
		require else
			setup_chess_precond(c, row, col)
    	do
			-- perform some update on the model state
			if
				model.op_cursor<model.operations.count
			then
				model.rm_pre_ops
			end
			if
				model.started
			then
				model.already_not_started_error(True)
			elseif
			    not model.is_valid_position (row, col)
			then
				model.set_not_valid_error (row, col)
			elseif
				model.chess_board.at(row).is_occupied(col)
			then
				model.set_not_occupied_error(row, col, True)
			else
				model.setup_chess(c, row , col)
			end
			etf_cmd_container.on_change.notify ([Current])
    	end

end
