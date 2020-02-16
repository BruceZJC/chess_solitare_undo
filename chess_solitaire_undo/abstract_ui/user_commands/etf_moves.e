note
	description: ""
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ETF_MOVES
inherit
	ETF_MOVES_INTERFACE
create
	make
feature -- command
	moves(row: INTEGER_32 ; col: INTEGER_32)
    	do
			-- perform some update on the model state
			if
				not model.started
			then
				model.already_not_started_error (false)
			elseif
				model.count =1 or model.over
			then
			    model.already_over_error
			elseif
				not model.is_valid_position (row,col)
			then
				model.set_not_valid_error (row, col)
			elseif
				not model.chess_board.at (row).is_occupied (col)
			then
			    model.set_not_occupied_error (row, col, false)
			else
				model.moves(row , col)
			end

			etf_cmd_container.on_change.notify ([Current])
    	end

end
