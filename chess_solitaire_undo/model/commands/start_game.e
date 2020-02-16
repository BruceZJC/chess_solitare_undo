note
	description: "Summary description for {START_GAME}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	START_GAME
inherit
	COMMANDS
create
	make
feature
	model :ETF_MODEL
	model_acc: ETF_MODEL_ACCESS
	tu:BOOLEAN
	fa:BOOLEAN
feature
	make
	  do
	  	model:=model_acc.m
	  	tu:=True
	  	fa:=False
	  end
feature
	execute
	  do
	  	model.started_switch (true)
        model.game_status.make_from_string ("Game In Progress...")
        if
        		model.count =1
        	then
        		model.game_status.make_from_string ("Game Over: You Win!")
        		model.over_swtich (true)
        	else
        	    if
        			model.number_of_possible_moves  =0
        		then
        			model.game_status.make_from_string ("Game Over: You Lose!")
        			model.over_swtich (true)
        		end
        	end
	  end
	undo
	  do
	    model.started_switch (false)
	    if
	    	model.over =true
	    then
	    	model.over_swtich (false)
	    end
        model.game_status.make_from_string ("Game being Setup...")
	  end
	redo
	  do
	  end


end
