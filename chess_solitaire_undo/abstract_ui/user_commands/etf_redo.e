note
	description: ""
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ETF_REDO
inherit
	ETF_REDO_INTERFACE
create
	make
feature -- command
	redo
    	do
			-- perform some update on the model state
			if
				model.operations.count = model.op_cursor
			then
				model.error.make_from_string ("Error: Nothing to redo")
			else
				model.redo
			end

			etf_cmd_container.on_change.notify ([Current])
    	end

end
