note
	description: "Summary description for {SETUP_CHESS}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SETUP_CHESS
inherit
	COMMANDS

create
	make
feature --attributes
    chess: CHARACTER
    r:INTEGER
    c:INTEGER
    cur_count:INTEGER
feature
	model :ETF_MODEL
	model_acc: ETF_MODEL_ACCESS
feature
	make(type:CHARACTER; row: INTEGER; col:INTEGER)
	  do
	  	chess :=type
	  	r :=row
	  	c := col
	  	model := model_acc.m
	  	cur_count:=model.count
	  end

feature
	execute
	  do
        model.chess_board.at (r).set (c, chess)
        model.count_op (cur_count+1)
	  end
	undo
	  do
	  	model.chess_board.at (r).set (c, '.')
	  	model.count_op (cur_count)
	  end
	redo
	  do
	  end
end
