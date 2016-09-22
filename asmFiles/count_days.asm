		org 0x0000

		ori $29, $zero , 0xFFFC # Stack Pointer

		ori $11 , $zero , 0x0013 # Current Day
		ori $12 , $zero , 0x0008 # Current Month
		ori $13 , $zero , 0x07E0 # Current Year
		
		ori $14 , $zero , 0x07D0 # 2000
		ori $15 , $zero , 0x016D # 365
		ori $16 , $zero , 0x001E # 30
		ori $17 , $zero , 0x0001 # 1

		sub $1, $13, $14	# (Current Year - 2000)

		push $1
		push $15
		jal MULT_SR         # (Current Year - 2000)*365
		pop $1
		 
		sub $2, $12, $17	# (Current Month - 1)
		push $2
		push $16

		#halt

		jal MULT_SR         # (Current Month - 1)*30
		pop $2

		addu $2, $2, $1		# (Current Month - 1)*30 + (Current Year - 2000)*365
		addu $2, $11, $2	# CurrentDay + (Current Month - 1)*30 + (Current Year - 2000)*365 

		push $2

		halt

MULT_SR:
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

		# todo: change loops to accomodate multiplication by 0

loop:	addu $26, $26, $23
		addiu $25, $25, 1
		bne $25, $24, loop

		push $26
		#halt
		jr $31
