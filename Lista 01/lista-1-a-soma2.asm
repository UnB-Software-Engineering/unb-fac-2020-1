.data
	enter: .asciiz "\n"
.text 
main:		
	li $v0, 5 		#le valor digitado
	syscall
	
	move $t1, $v0 		#salva em t1

	li $v0, 5 		#le valor digitado
	syscall
	
	move $t2, $v0 		#salva em t2
	
	add $t1, $t1, $t2 	#soma += t2


	# impime	
	li $v0, 1
	move $a0, $t1
	syscall
	
	# imprime espaco
	li $v0, 4
	la $a0, enter
	syscall 

	# sai do programa
	li $v0, 10
	syscall
<!--stackedit_data:
eyJoaXN0b3J5IjpbMTc2ODQyNjMwOV19
-->
