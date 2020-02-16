note
	description: ""
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ETF_UNDO
inherit
	ETF_UNDO_INTERFACE
create
	make
feature -- command
	undo
    	do
			-- perform some update on the model state
			if
				model.op_cursor=0 or model.operations.count =0
			then
				model.error.make_from_string ("Error: Nothing to undo")
			else
				model.undo
			end

			etf_cmd_container.on_change.notify ([Current])
    	end

end
