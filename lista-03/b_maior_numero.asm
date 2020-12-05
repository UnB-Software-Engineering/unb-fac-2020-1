# Larissa Sales 160130883
# Luciana Ribeiro 150016131

.data
	newline: .asciiz "\n"
.text

main:

	li $v0, 5 		# lê N
	syscall
	move $t0, $v0           # move N para t0
	
	li $t1, 0               # inicializa i=0 em t1 
	li $t3, 0		# inicializa aux=0 em t3
	
	li $v0, 5 		# lê número 
	syscall
	move $t3, $v0		# salva numero em t3
	
	addi $t1, $t1, 1	# i++
	
while:
	beq $t1, $t0, exit      # se i=N vai para exit
	
	li $v0, 5 		# lê número 
	syscall
	move $t2, $v0		# salva numero em t2
	
	## add $t3, $t2, $zero	# aux = t2
	
	bge $t2, $t3, if	# se numero >= aux vai para if
	blt $t2, $t3, else	# se numero < aux vai para else

if:
	move $s0, $t2		# s0=t2
	move $t3, $t2		# aux=t2

else: 
	move $s0, $t3
	move $t3, $t3		# aux=aux (não muda)

	addi $t1, $t1, 1	# i++
		
	j while 		# vai para while

exit:
	li $v0,1 		# print do numero na tela
	la $a0, ($s0) 		# printa registrador $s0 
	syscall 
			
	li $v0, 4		# print do \n
	la $a0, newline
	syscall
		
	li $v0, 10 		# exit
	syscall 
