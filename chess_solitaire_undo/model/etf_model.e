note
	description: "A default business model."
	author: "Jackie Wang"
	date: "$Date$"
	revision: "$Revision$"

class
	ETF_MODEL

inherit
	ANY
		redefine
			out
		end

create {ETF_MODEL_ACCESS}
	make

feature {NONE} -- Initialization
	make
			-- Initialization for `Current'.
		do
		-----lab4
		    create operations.make
		    op_cursor :=0
		-----lab3---------------------------------------------------------------------------
			started.set_item (false)
			over.set_item(false)
			display_move.set_item(false)
			count :=0
			create game_status.make_from_string ("Game being Setup...")
        -----initial chess boards			
			create chess_board.make
			create tmp_board.make
			chess_board.extend (create {ROW}.make (1))
			chess_board.extend (create {ROW}.make (2))
			chess_board.extend (create {ROW}.make (3))
			chess_board.extend (create {ROW}.make (4))

		------initial error msgs
		    create error.make_empty

		end

feature -- model attributes
--lab4
    operations: LINKED_LIST[COMMANDS]
    op_cursor : INTEGER
--lab3
	started : BOOLEAN
	over :BOOLEAN
	display_move :BOOLEAN
	game_status :STRING
	chess_board :LINKED_LIST[ROW]
	tmp_board: LINKED_LIST[ROW]
	count :INTEGER

	--error msg
	error: STRING


feature -- model operations
    reset
        do
        	make
        end
    reset_game
        do
        	across
        		chess_board as pt
        	loop
        		pt.item.reset_row
        	end
        	count :=0
        	op_cursor:=0
        	game_status := "Game being Setup..."
        	started :=false
        	over :=false
        	create operations.make
        end


    moves(row :INTEGER ;col :INTEGER)
        local
        	i :INTEGER
        	j :INTEGER
        do
          display_move:= True
          tmp_board  :=  chess_board.deep_twin
          from
          	i:= 1
          until
          	i=5
          loop
          	from
          		j:=1
          	until
          		j=5
          	loop
          		if
          			is_valid_move (row, col, i, j)
          		then
          			tmp_board.at (i).set (j, '+')
          		elseif
          			not (row = i and col = j)
          		then
          			tmp_board.at (i).set (j, '.')
          		end
          		j:=j+1
          	end
          	i:=i+1
          end
        end
--------------------------------------------------------------------------------
    move_and_capture(r1:INTEGER; c1:INTEGER ; r2 :INTEGER ; c2: INTEGER)
        do
            op_cursor := op_cursor+1
            operations.force (create{MOVE_AND_CAPTURE}.make (r1, c1, r2, c2))
            operations.at (op_cursor).execute
        end


   setup_chess(c:INTEGER; row:INTEGER ; col: INTEGER)
        do
        	op_cursor:= op_cursor+1
            operations.force (create{SETUP_CHESS}.make (to_chess (c),row,col))
            operations.at (op_cursor).execute
        end

   start_game
        do
            op_cursor:= op_cursor +1
        	operations.force (create{START_GAME}.make)
        	operations.at (op_cursor).execute
        end

   undo
        do
        	operations.at (op_cursor).undo
        	op_cursor:= op_cursor -1
        end
   redo
        do
        	operations.at (op_cursor+1).execute
        	op_cursor:= op_cursor+1

        end
--------helper methods-----------------------------------------------------------------------------------
---lab4--
   rm_pre_ops
        local
        	tmp:LINKED_LIST[COMMANDS]
        	i:INTEGER
        do
        	create tmp.make
        	from
        		i:=1
        	until
        		i=op_cursor+1
        	loop
        		tmp.force (operations.at (i))
        		i:=i+1
        	end
        	operations:=tmp
        end
   started_switch(a:BOOLEAN)
        do
           started:=	a
        end
   over_swtich(a:BOOLEAN)
        do
        	over:=a
        end
   count_op(a:INTEGER)
        do
        	count:= a
        end
  --lab3--
   number_of_possible_moves:INTEGER
        local
        	i:INTEGER
        	j:INTEGER
        do
          Result:=0
          from
          	i:= 1
          until
          	i=5
          loop
          	from
          		j:=1
          	until
          		j=5
          	loop
          		Result := Result + possible_moves(i,j)
          		j:=j+1
          	end
          	i:=i+1
          end
        end
   possible_moves(r:INTEGER ;c:INTEGER):INTEGER
        local
            i:INTEGER
            j:INTEGER
            mvs:INTEGER
        do
          Result:=0
          from
          	i:= 1
          until
          	i=5
          loop
          	from
          		j:=1
          	until
          		j=5
          	loop
          		if
          			is_valid_move (r, c, i, j) and chess_board.at (i).is_occupied (j)
          		then
          			mvs := mvs+1
          		end
          		j:=j+1
          	end
          	i:=i+1
          end
          Result := mvs
        end
   is_valid_position(n1:INTEGER ;n2:INTEGER):BOOLEAN
        do
        	Result := n1 <5 and n1 >0 and n2 < 5 and n2 >0
        end

   to_chess(a:INTEGER) :CHARACTER
        local
        	chs: ARRAY[CHARACTER]
        do
            chs := <<'K','Q','N','B','R','P'>>
        	Result :=chs.at (a)
        end

   is_valid_move(a1:INTEGER; a2:INTEGER; b1:INTEGER; b2:INTEGER):BOOLEAN
        do
        	inspect
        		chess_board.at (a1).at (a2)
        	when 'B' then
        		Result := valid_for_bishop (a1, a2, b1, b2)
            when 'R' then
                Result := valid_for_rook (a1, a2, b1, b2)
            when 'Q' then
                Result := valid_for_bishop (a1, a2, b1, b2) or valid_for_rook (a1, a2, b1, b2)
            when 'K' then
            	Result := (a1 = b1 and (b2-a2)^2=1) or (b2 =a2 and (a1-b1)^2 =1) or ((b2-a2)^2=1 and (b1-a1)^2=1)
            when 'P' then
                Result := valid_for_bishop (a1, a2, b1, b2) and (a1-b1) =1
            when 'N' then
            	Result := not valid_for_bishop (a1, a2, b1, b2) and
            	         not valid_for_rook (a1, a2, b1, b2) and
            	         not(a1=b1 and a2=b2) and
            	         (b1-a1)^2 <= 4 and
            	         (b2-a2)^2 <= 4
        	else
        		Result := false
        	end

        end
   valid_for_bishop(a1:INTEGER; a2:INTEGER; b1:INTEGER; b2:INTEGER) :BOOLEAN
        do
        	Result := (b1-a1)*(b1-a1)= (b2-a2)*(b2-a2) and not(a1=b1 and  a2=b2)
        end
   valid_for_rook(a1:INTEGER; a2:INTEGER; b1:INTEGER; b2:INTEGER) :BOOLEAN
        do
        	Result := a1 = b1 xor a2=b2
        end

   not_blocked_move(a1:INTEGER; a2:INTEGER; b1:INTEGER; b2:INTEGER):BOOLEAN
        do
        	inspect
        		chess_board.at (a1).at (a2)
        	when 'B' then
        		Result := not is_blocked_for_bishop (a1, a2, b1, b2)
            when 'R' then
                Result := not is_blocked_for_rook (a1, a2, b1, b2)
            when 'Q' then
            	if
            		valid_for_bishop (a1, a2, b1, b2)
            	then
            		Result :=not is_blocked_for_bishop (a1, a2, b1, b2)
            	else
            	    Result :=not is_blocked_for_rook (a1, a2, b1, b2)
            	end

            when 'N' then
            	Result := not is_blocked_for_knight (a1,a2,b1,b2)
        	else
        		Result := false
        	end

        end

   is_blocked_for_bishop(n1:INTEGER;n2:INTEGER;m1:INTEGER;m2:INTEGER):BOOLEAN
        local
        	i :INTEGER
        	j:INTEGER
        do
        	if
        		not valid_for_bishop (n1,n2,m1,m2)
        	then
        		Result := false
        	else
            Result := True
--1
        	if
        		m1-n1<0 and m2-n2>0
        	then

        		from
        			i:=m1+1
        			j:=m2-1
        		until
        			(i=n1 and j=n2) or Result =false
        		loop
        			Result := not chess_board.at (i).is_occupied (j)
        			i:=i+1
        			j:=j-1
        		end
--2
        	elseif
        		m1-n1>0 and m2-n2 >0
        	then
        	    from
        	    	i := m1-1
        	    	j := m2-1
        	    until
        	    	(i=n1 and j=n2) or Result =false
        	    loop
        	    	Result := not chess_board.at (i).is_occupied (j)
        	    	i :=i-1
        	    	j :=j-1
        	    end
--3
        	elseif
        		m1-n1>0 and m2-n2<0
        	then
        		from
        			i:=m1-1
        			j:=m2+1
        		until
        			(i=n1 and j=n2) or Result =false
        		loop
        			Result := not (chess_board.at (i).is_occupied (j))
        			i:=i-1
        			j:=j+1
        		end
--4
        	else
        		from
        			i:=m1+1
        			j:=m2+1
        		until
        			(i=n1 and j=n2) or Result =false
        		loop
        			Result := not (chess_board.at (i).is_occupied (j))
        			i:=i+1
        			j:=j+1
        		end

        	end
            end
        end
   is_blocked_for_rook(row1:INTEGER;col1:INTEGER;row2:INTEGER;col2:INTEGER;):BOOLEAN
        local
        i:INTEGER
        do
            Result:= True
        	if
        		row1 =row2 and col1< col2
        	then
        		from
        			i := col2-1
        		until
        			i=col1 or Result = false
        		loop
        			Result := not chess_board.at (row1).is_occupied (i)
        			i:=i-1
        		end
            elseif
            	row1 =row2 and col1> col2
            then
            	from
            		i := col2+1
            	until
            		i =col1 or Result = false
            	loop
            		Result := not chess_board.at (row1).is_occupied (i)
            		i:=i+1
            	end
            elseif
            	col1 =col2 and row2 >row1
            then
            	from
            		i :=row2 -1
            	until
            		i=row1 or Result =false
            	loop
            		Result := not chess_board.at (i).is_occupied (col1)
            		i:=i-1
            	end
            else
                from
            		i :=row2 +1
            	until
            		i=row1 or Result =false
            	loop
            		Result := not chess_board.at (i).is_occupied (col1)
            		i:=i+1
            	end
        	end
        end
    is_blocked_for_knight(row1: INTEGER;col1: INTEGER;row2: INTEGER;col2: INTEGER;):BOOLEAN
        local
        	i:INTEGER
        	j:INTEGER
        do
        	Result:=True
        	--1
        	if
        	    row1 >row2
        	then
        		    from
        		    	i:= row2
        		    until
        		    	i = row1 or Result =false
        		    loop
        		        Result := not chess_board.at (i).is_occupied (col1)
        		        i :=i+1
        		    end
        		--sub11
        		if
        		    col2>col1 and Result =True
        		then
        		    from
        		    	j := col1
        		    until
        		    	j = col2
        		    loop
        		    	Result := not chess_board.at (row2).is_occupied (j)
        		    	j := j+1
        		    end
        		--sub12	
        		elseif
        			Result =True
        		then
        		    from
        		    	j := col1
        		    until
        		    	j = col2 or Result =false
        		    loop
        		    	Result := not chess_board.at (row2).is_occupied (j)
        		    	j :=j-1
        		    end
        		end
        	--2	
        	else
        	        from
        		    	i:= row2
        		    until
        		    	i = row1 or Result =false
        		    loop
        		        Result := not chess_board.at (i).is_occupied (col1)
        		        i :=i-1
        		    end
        		--sub21
        		if
        		    col2>col1 and Result =True
        		then

        		    from
        		    	j := col1
        		    until
        		    	j = col2 or Result =false
        		    loop
        		    	Result := not chess_board.at (row2).is_occupied (j)
        		    	j := j+1
        		    end
        		--sub12	
        		elseif
        			Result =True
        		then
        		    from
        		    	j := col1
        		    until
        		    	j = col2
        		    loop
        		    	Result := not chess_board.at (row2).is_occupied (j)
        		    	j :=j-1
        		    end
        		end
        	--2	
        	end
        end

--------------------   error reporting   ----------------------------------------------------------------------------
   set_not_occupied_error(n1:INTEGER; n2 :INTEGER; key: BOOLEAN)
        do
        	if
        	   key
        	then
        	   error.append ("Error: Slot @ (")
        	   error.append (n1.out)
               error.append (", ")
        	   error.append (n2.out)
        	   error.append (") already occupied")
        	else
        	   error.append ("Error: Slot @ (")
        	   error.append (n1.out)
               error.append (", ")
        	   error.append (n2.out)
        	   error.append (") not occupied")
        	end


        end
   set_not_valid_error(n1:INTEGER ; n2 :INTEGER)
        do
        	error.append("Error: (")
        	error.append(n1.out)
        	error.append(", ")
        	error.append(n2.out)
        	error.append(") not a valid slot")
        end
   already_not_started_error(switch :BOOLEAN)
        do
        	if
        		switch =True
        	then
        		error.append ("Error: Game already started")
            else
            	error.append ("Error: Game not yet started")
        	end

        end
   already_over_error
        do
        	error.append ("Error: Game already over")
        end
   invalid_move_error(n1:INTEGER n2:INTEGER m1:INTEGER m2:INTEGER)
        do
        	error.append ("Error: Invalid move of ")
        	error.append_character (chess_board.at (n1).at (n2))
        	error.append (" from (")
        	error.append (n1.out)
        	error.append (", ")
        	error.append (n2.out)
        	error.append (") to (")
        	error.append (m1.out)
        	error.append (", ")
        	error.append (m2.out)
        	error.append (")")

        end
    set_blocked_error(n1:INTEGER n2:INTEGER m1:INTEGER m2:INTEGER)
        do
            error.append ("Error: Block exists between (")
            error.append (n1.out)
            error.append (", ")
            error.append (n2.out)
            error.append (") and (")
            error.append (m1.out)
            error.append (", ")
            error.append (m2.out)
            error.append (")")
        end
feature -- queries
	out : STRING
	    local
	        ct :INTEGER
		do
			create Result.make_empty

			    Result.append ("  # of chess pieces on board: ")
				Result.append (count.out)
				Result.append_character ('%N')

			if
				not error.is_empty
			then
				Result.append ("  ")
				Result.append(error)
				Result.append_character('%N')
				error.make_empty
			else
				Result.append ("  ")
				Result.append (game_status)
				Result.append_character ('%N')

			end

			if
				display_move = True
			then

				  from
				  ct :=1
			      until
				  ct = 5
			      loop
			      Result.append ("  ")
				  Result.append (tmp_board.at (ct).stringify)
				  if
				  	ct /=4
				  then
				  	Result.append_character('%N')
				  end
				  ct := ct+1
				  end
				  display_move :=false
			else
				  from
				  ct :=1
			      until
				  ct = 5
			      loop
			      Result.append ("  ")
				  Result.append (chess_board.at (ct).stringify)
				  if
				  	ct /=4
				  then
				  	Result.append_character('%N')
				  end
				  ct := ct+1
				  end
			end

		end

end




