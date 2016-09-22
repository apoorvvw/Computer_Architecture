		org 0x0000
		
		ori $29, $zero , 0xFFFC #Stack Pointer
		
		ori $1 , $zero , 0x0002 # OP1 
		ori $2 , $zero , 0x0005 # OP2

		push $1
		push $2

		pop $3	# Get from stack
		pop $4

		and $5, $zero, $5 # Loop control variable
		and $6, $zero, $6 # Accumulator 
loop:	addu $6, $6, $3
		addiu $5, $5, 1
		bne $5, $4, loop

		push $6

		halt
