# Larissa Sales 160130883
# Luciana Ribeiro 150016131

.data
	endline: .asciiz "\n"
	invalid: .asciiz "Entradas invalidas"
	notPrime: .asciiz "O modulo nao eh primo"
	inverse: .asciiz "inverso = "
	
.text
main: 	
	li $v0, 5             # le p
      	syscall               
      	move $a1, $v0         # move p para a1
      	
      	li $v0, 5             # le a
      	syscall                
      	move $a0, $v0         # move a para a0
      	
      	ble $a0, 1, errorInvalid	# se p<=1, vai para error1
      	ble $a1, 1, errorInvalid	# se a<=1, vai para error1

      	addi $t9, $a1, 0	# t9=ai (p)      	
      	addi $t8, $a0, 0	# t8=a0 (a)

      	jal modulo		# calcula modulo
      	
      	beqz $a0, errorInvalid	# se a0==0, vai para errorInvalid 
      	
      	addi $a0, $t8, 0	# a0=t8
      	addi $a1, $t9, 0	# a1=t9
      	
      	jal isPrime		# verifica se eh primo
      	
calculate:
     	addi $a0, $t8, 0	# a0=t8
      	addi $a1, $t9, 0	# a1=t9
      	    	
exponentiation: 
	addi $t0, $a0, 0	# t0 = a
	addi $t1, $a1, -2       # t1 = p - 2
	
	blez $t1, outLoop	# se t1<=0, vai para depois do loop
	addi $t1, $t1, -1	# t1--
	
loopExpo: 
	blez $t1, endExpo	# se t1<=0, vai para final da funcao

	mul $t0, $t0, $a0	# t0= t0*a0
	addi $t1, $t1, -1	# t1--
	
	j loopExpo		# volta pro inicio do loop

outLoop:
	addi $t0, $0, 1		# t0 = 1
	
endExpo:
	addi $a0, $t0, 0	# a0 = t0

# end exponentiation
      	
      	addi $t0, $a0, 0	# t0 = a0
	
	jal modulo		# calcula modulo
	
	addi $t0, $a0, 0	#t0=a0
	
	li $v0, 4            	# print
	la $a0, inverse 	
	syscall              	
	
	addi $a0, $t0, 0	# print valor
	li $v0, 1
	syscall

	j exit

modulo: 
	addi $t0, $a0, 0	# t0 = a0
	addi $t1, $a1, 0        # t1 = ai
	div  $t2, $t0, $t1      # t2 = t0/t1
	mul  $t3, $t2, $t1      # t3 = t2*t1
	sub  $t0, $t0, $t3	# t0 = t0 - t3

	add $a0, $t0, $0	# a0 = t0
	jr $ra			# retorna

# end modulo

isPrime:
	addi $t0, $0, 1		# t0 = 1
	addi $t1, $0, 2		# t1 = 2
	
	ble $a1, $t0, errorNotPrime	# se a1 <= 1, nao eh primo
	beq $a1, $t1, calculate		# se a1 == 2, eh primo
	
	addi $a0, $a1, 0	# a0 = a1
	addi $a1, $t1, 0	# a1 = t1
	
	jal modulo		# calcula modulo e depois retorna
	
	beqz $a0, errorNotPrime	# se a0 == 0. nao eh primo
	
	addi $t7, $0, 3		# t7 = 3 
	
loopIsPrime:
	addi $t2, $t9, -1	# t2 = t9 - 1
	bge $t7, $t2, calculate	# se t7 >= t2, calcula 
	
	addi $a0, $t9, 0	# a0 = t9
	addi $a1, $t7, 0	# ai = t7
	addi $t7, $t7, 2	# t7 = t7 - 2
	
	jal modulo		# calcula modulo e depois retorna
	
	beqz $a0, errorNotPrime	# se a0 == 0, nao eh primo
	
	j loopIsPrime		# inicio do loop
	
	jr $ra			# retorna

errorInvalid:
	li $v0, 4		# print
	la $a0, invalid
	syscall
	
	j exit 			# vai para exit

errorNotPrime:				
	li $v0, 4		# print
	la $a0, notPrime
	syscall
	
	j exit 			# vai para exit
	
exit:      
	li $v0, 10		# exit
	syscall
