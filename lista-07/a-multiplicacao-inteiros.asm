.data
	newline: .asciiz "\n"
	lo: .asciiz "lo = "
	hi: .asciiz "hi = "
.text

main:
	li $v0, 5 		# le numero
	syscall
	move $a0, $v0           # move numero para a0 (multiplicando)
	
	li $v0, 5 		# le numero
	syscall
	move $a1, $v0           # move numero para a1 (multiplicador)
	
	jal multfac
	
	li $v0, 4		# print do lo
	la $a0, lo
	syscall
	
	li $v0,1 		# print do numero na tela
	la $a0, ($t1) 		# printa registrador $t1 
	syscall
	
	li $v0, 4		# print do \n
	la $a0, newline
	syscall
	
	li $v0, 4		# print do hi
	la $a0, hi
	syscall
	
	li $v0,1 		# print do numero na tela
	la $a0, ($t0) 		# printa registrador $t0 
	syscall
	
	li $v0, 4		# print do \n
	la $a0, newline
	syscall
	
	li $v0, 10 		# exit
	syscall 
	
multfac:
	mul $t2, $a0, $a1
	
	mfhi $t0		# resto
	
	mflo $t1		# resultado
	
	jr $ra			# retorna
