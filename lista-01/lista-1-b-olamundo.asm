.data
	str: .asciiz "Ola Mundo\n"
.text 
main:		
	# imprime 
	li $v0, 4
	la $a0, str
	syscall 

	# sai do programa
	li $v0, 10
	syscall
