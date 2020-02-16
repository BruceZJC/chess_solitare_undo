note
	description: ""
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ETF_MOVE_AND_CAPTURE
inherit
	ETF_MOVE_AND_CAPTURE_INTERFACE
create
	make
feature -- command
	move_and_capture(r1: INTEGER_32 ; c1: INTEGER_32 ; r2: INTEGER_32 ; c2: INTEGER_32)
    	do
			-- perform some update on the model state
			if
				model.op_cursor<model.operations.count
			then
				model.rm_pre_ops
			end
			if
				not model.started
			then
				model.already_not_started_error (false)
			elseif
				model.over
			then
				model.already_over_error
			elseif
			    model.count ~1
			then
				model.already_over_error
		    elseif
		    	not model.is_valid_position (r1, c1)
		    then
		    	model.set_not_valid_error (r1, c1)
		    elseif
		    	not model.is_valid_position (r2, c2)
		    then
		    	model.set_not_valid_error (r2, c2)
		    elseif
		    	not model.chess_board.at (r1).is_occupied (c1)
		    then
		        model.set_not_occupied_error (r1,c1, false)
		    elseif
		    	not model.chess_board.at (r2).is_occupied (c2)
		    then
		    	model.set_not_occupied_error (r2, c2,false)
		    elseif
		    	not model.is_valid_move (r1, c1, r2, c2)
		    then
		        model.invalid_move_error(r1,c1,r2,c2)

		    elseif
		    	model.not_blocked_move (r1, c1, r2, c2)
		    then
		    	model.set_blocked_error (r1,c1,r2,c2)
		    else
				model.move_and_capture(r1,c1,r2,c2)
			end

			etf_cmd_container.on_change.notify ([Current])
    	end

end
