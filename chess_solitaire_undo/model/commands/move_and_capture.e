note
	description: "Summary description for {MOVE_AND_CAPTURE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	MOVE_AND_CAPTURE
inherit
	COMMANDS

create
	make
feature---access to the etf model
	model :ETF_MODEL
	model_acc: ETF_MODEL_ACCESS
feature
	ro1,co1,ro2,co2: INTEGER
	mem_1,mem_2:CHARACTER
	cur_count:INTEGER
feature
	make(r1:INTEGER; c1:INTEGER ; r2 :INTEGER ; c2: INTEGER)
	  do
	  	ro1:=r1
	  	co1:=c1
	  	ro2:=r2
	  	co2:=c2
	  	model := model_acc.m
	  	cur_count:= model.count
	  end

feature
	execute
	  do
	  	mem_1 := model.chess_board.at (ro1).at (co1).deep_twin
	  	mem_2 := model.chess_board.at (ro2).at (co2).deep_twin
        model.chess_board.at (ro1).set (co1,'.')
        model.chess_board.at (ro2).set (co2, mem_1)
        model.count_op (cur_count-1)
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
	  	model.chess_board.at (ro1).set (co1, mem_1)
	  	model.chess_board.at (ro2).set (co2, mem_2)
	  	model.count_op (cur_count)
	  	if
	  		model.over
	  	then
	  		model.over_swtich (false)
	  		--model.started_switch (false)
	  		model.game_status.make_from_string ("Game In Progress...")
	  	end
	  end


	redo
	  do
	  end


end
