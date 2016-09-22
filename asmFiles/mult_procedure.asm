		org 0x0000

		ori $29, $zero , 0xFFFC # Stack Pointer
		
		ori $11 , $zero , 0x0004 # OP1 
		ori $12 , $zero , 0x0002 # OP2
		ori $13 , $zero , 0x0002 # OP3
		ori $14 , $zero , 0x0003 # OP4
		
		ori  $4 , $zero , 0x0004 # Stores 0x0004
		sub $1, $29, $4 		 # $29 - 0x0004
		
		# Push as many operands here 
		push $11
		push $12
		push $13
		push $14


back:	beq $1 , $29, exit # if the stack only has one element
		j mult_sr	

exit:	halt


mult_sr:
		#************************************
		#			MULT_SR
		#
		# $23 - OP1   ; $24 - OP2
		# $25 - LCV   ; $26 - Accumulator
		#************************************
		
		pop $23
		pop $24

		and $25, $zero, $25 # Loop control variable = 0
		and $26, $zero, $26 # Accumulator = 0

loop:	addu $26, $26, $23
		addiu $25, $25, 1
		bne $25, $24, loop

		push $26

		j back
