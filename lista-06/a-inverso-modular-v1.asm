# Larissa Sales 160130883
# Luciana Ribeiro 150016131

.data
	newline: .asciiz "\n"
	invalid: .asciiz "Entradas invalidas\n"
	notPrime: .asciiz "O modulo nao eh primo\n"
	invert: .asciiz "inverso = "

.text

main:
	li $v0, 5 	# le p
	syscall
	move $t0, $v0	# move p para t0
	
	li $v0, 5 	# le a
	syscall
	move $t1, $v0	# move a para t1
	
	li $t2, 2	# inicializa t2=2 (aux) para calculo do primo

	# verifica se sao maiores que 1
		
	ble $t0, 1, errorInvalid	# se p<=1, vai para error1
	ble $t1, 1, errorInvalid	# se a<=1, vai para error1

# verifica se p eh primo
isPrimeTest:	
	slt $t8, $t2, $t0
	bne $t8, $zero, loopIsPrime
	addi $v0, $zero, 1
	j isMultiple
	
loopIsPrime:
	div $t0, $t2
	mfhi $t9
	slti $s7, $t9, 1
	beq $s7, $zero, isPrimeLoopContinue
	add $v0, $zero, $zero
	j errorNotPrime
	
isPrimeLoopContinue:
	addi $t2, $t2, 1
	j isPrimeTest

# verifica se sao multiplos	
isMultiple:	
	bgt $t1, $t0, a_by_p		# se a>p, vai para a/p
	
	div $t0, $t1			# p/a
	mfhi $t3			# salva o resto em $t3
	bne $t3, $0, calculate		# se $t3!=0, nao sao multiplos e pode continuar
	beqz $t3, errorInvalid		# se $t3==0,  nao pode continuar e vai para error1	
			
a_by_p:
	div $t1, $t0			# a/p
	mfhi $t3			# salva o resto em $t3
	bne $t3, $0, calculate		# se $t3!=0, nao sao multiplos e pode continuar
	beqz $t3, errorInvalid		# se $t3==0,  nao pode continuar e vai para error1
	
# entradas invalidas
errorInvalid: 			
	li $v0, 4		# print
	la $a0, invalid
	syscall
	
	j exit 			# vai para exit

# p nao eh primo
errorNotPrime:				
	li $v0, 4		# print
	la $a0, notPrime
	syscall
	
	j exit 			# vai para exit
	
calculate:

	li $s1, 0		# y = 0
	li $s2, 1		# x = 1

	move $t5, $t0		# p0 = p
	
loop:
	ble $t1, 1, out		# se a <= 1, sai do loop
	div $t1, $t0		# a/p
	mflo $s0		# q = a/p
	
	move $t6, $t0		# t = p
	
	# euclides
	div $t1, $t0		# a/p
	mfhi $t0		# salvando o resto em t0
		
	move $t1, $t6 		# a = t
	move $t6, $s1		# t = y
	
	mul $s4, $s0, $s1	# aux = q*y
	sub $s1, $s2, $s4	# y = x - aux
	
	move $s2, $t6		# x = t
	
	j loop
	
out: 	
	bltz $s2, positive	# se x < 0, tornar x positivo
	bgez $s2, end		# se x >= 0, finaliza
	
positive:
	add $s2, $s2, $t5	# x += p0

end:	
	li $v0, 4            	# print
	la $a0, invert 	
	syscall              	
	
	addi $a0, $s2, 0	# print valor
	li $v0, 1
	syscall
	
	li $v0, 4            	# print
	la $a0, newline 	
	syscall 

exit:		
	li $v0, 10 		# exit
	syscall 
