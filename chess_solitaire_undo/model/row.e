note
	description: "Summary description for {ROW}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ROW
create
	make

feature --attribute
    array : ARRAY[CHARACTER]
    rowNumber :INTEGER

feature --Commands
    make(rn: INTEGER)
       do
       	create array.make_empty
       	rownumber := rn

       	array.force ('.', 1)
       	array.force ('.', 2)
       	array.force ('.', 3)
       	array.force ('.', 4)
       end
    at(i :INTEGER):CHARACTER
       do
       	Result := array[i]
       end

    set(s :INTEGER; it :CHARACTER)
       do
       	array[s] := it
       end

    is_occupied(a: INTEGER) :BOOLEAN
       require
       	a <= 4 and a >=1
       do
       	Result := array[a] /~ '.'
       end

    stringify:STRING
       local
       	tmp :INTEGER
       do
       	create Result.make_empty
       	from
       		tmp :=1
       	until
       		tmp =5
       	loop
       		Result.append_character (array[tmp])
       		tmp := tmp+1
       	end
       	    
       end


     reset_row
       local
       	 a:INTEGER
       do
       	from
       		a:=1
       	until
       		a=5
       	loop
       		array[a]:='.'
       		a:=a+1
       	end
       end
-------helper method



end
