# Larissa Siqueira Sales 160130883
# Luciana Ribeiro Lins de Albuquerque 150016131

.data
	size: .space 33
	base64: .byte 'A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z','a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z','0','1','2','3','4','5','6','7','8','9','+','/'
	endOfString: .word 0
	endLine: .asciiz "\n"
	
.text
main:
	li $v0,8		# le string
	la $a0, size 		# carrega size
	li $a1, 33		# allot the byte space for string
	move $t0,$a0 		# save string to t0
	syscall
	
	li $t8, 10		# t8=10
	lb $t9, endOfString
loop:
	lb $t1, 0($t0)
	beq $t1, $t8, exit	# if t1 == t8, vai para exit
	beq $t1, $t9, exit	# if t1 == t9, vai para exit
	andi $t4, $t1, 0xFF	# t4 = t1 + 0xFF
	
	sll $t4, $t4, 8		# t4 = shift left de t4
	li $t1, 0		# t1=0
	
	lb $t2, 1($t0)
	beq $t2, $t8, invalid2	# if t2 == t8, vai para invalid2
	beq $t2, $t9, invalid2	# if t2 == t9, vai para invalid2
	
validate3:
	andi $t5, $t2, 0xFF	# t5 = t2 + 0xFF

	add $t4, $t4, $t5	# t4+=t5
	sll $t4, $t4, 8		# t4 = shift left de t4
	li $t2, 0		# t2=0

	lb $t3, 2($t0)
	beq $t3, $t8, invalid3	# if t3 == t8, vai para invalid3
	beq $t3, $t9, invalid3	# if t3 == t9, vai para invalid3
	
afterValidation:
	andi $t5, $t3, 0xFF	# t5 = t3 + 0xFF
	add $t4, $t4, $t5	# t4 += t5
	move $a0, $t4		# a0=t4
	move $t3, $t4		# t3=t4
	
	jal convertionBase64	# chama funcao convertionBase64
	
	addi $t0, $t0, 3	# t0+=3
	j loop			# retorna pro inicio do loop

convertionBase64:
	move $t7, $ra		# t7=ra (retorno da funcao)
	srl $t4, $t3, 18	# t4 = shift right de t3
	andi $t4, $t4, 0x3F	# t4 += 0x3F
	jal printBase64		# chama funcao printBase64

    	srl $t4, $t3, 12	# t4 = shift right de t3
	andi $t4, $t4, 0x3F	# t4 += 0x3F
	jal printBase64		# chama funcao printBase64

	bnez $t1, print2	# if t1 != 0, vai para print2
	andi $t4, $t3, 0xFC0	# t4 = t3 + 0xFC0
	srl $t4, $t4, 6		# t4 = shift right de t4
	jal printBase64		# chama funcao printBase64

afterPrint2:
	bnez $t2, print3	# if t2 != 0, vai para print3
	andi $t4, $t3, 0x3F	# t4 = t3 + 0x3F
	jal printBase64		# chama funcao printBase64

	move $ra, $t7		# ra = t7
	jr $ra			# retorna

print2:
	li $v0, 11		# v0 = 11
	li $a0, 61		# a0 = 61
	syscall
	j afterPrint2		# vai para afterPrint2
	
print3:
	li $v0, 11		# v0 = 11
	li $a0, 61		# a0 = 61
	syscall
	
	move $ra, $t7		# ra = t7
	jr $ra			# retorna

printBase64:
	lb $a0, base64($t4)	
	li $v0, 11		# v0 = 11
	syscall	
	
	jr $ra			# retorna

invalid2:
	li $t1, 1		# t1=1
	li $t2, 0		# t2=0
	j validate3		# vai para validate3
	
invalid3:
	li $t2, 1		# t2=1
	li $t3, 0		# t3=0
	j afterValidation	# vai para afterValidation
	
endline: 
	li $v0, 4		# print \n
	la $a0, endLine	
	syscall
	
	jr $ra			# retorna

exit:
	jal endline		# \n
	li $v0, 10		# sai
	syscall
