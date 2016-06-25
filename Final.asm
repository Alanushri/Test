.data
	matrix: .space 100
	iterator: .word 0
	size: .word 25
	
	message1: .asciiz "\n Enter number: "
	message2: .asciiz "\n Now the 2D matrix is: \n"
	message3: .asciiz "\n What function do you want to perform?"
	message4:.asciiz "\n 0. Exit \n 1. Swap rows \n 2. Swap columns \n"
	message5: .asciiz "\n Enter row1: "
	message6: .asciiz "\n Enter row2: "
	message7: .asciiz "\n Enter column1: "
	message8: .asciiz "\n Enter column2: "
	newline: .asciiz "\n"
	space:   .asciiz " "
	
.text
main: 
	la $t0, matrix
	lw $t1, iterator
	lw $t2, size
	addi $t3, $zero, 0
	
	#Enter numbers for the 5x5 matrix
	enterNumberLoop:
	bge $t1, $t2, exitNumberLoop
	li $v0, 4
	la $a0, message1
	syscall
	
	li $v0,5
	syscall
	
	addu $t3, $t3, $t0
	sw $v0, 0($t3)
	addi $t1, $t1, 1
	sll $t3, $t1, 2
	
	j enterNumberLoop
	
	exitNumberLoop:
	jal print
	
	swap:
	li $v0, 4
	la $a0, message3
	syscall
	
	li $v0, 4
	la $a0, message4
	syscall
	
	li $v0, 5
	syscall
	
	move $a1,$v0
	beq $a1, 0, exit
	beq $a1, 1, rowSwap
	beq $a1, 2, colSwap
	
	rowSwap:
	
	li $v0, 4
	la $a0, message5
	syscall
	li $v0, 5
	syscall
	
	move $a3, $v0
	
	li $v0, 4
	la $a0, message6
	syscall
	li $v0,5
	syscall
	
	move $s3, $v0
	
	la $t0, matrix
	lw $t1, iterator

	mul $a3, $a3, 5
	mul $s3, $s3, 5
	
	Rswap:
	beq  $t1, 5, exitRowSwap
	#Fisrt element to be swapped
	add $t6, $a3, $t1
	mul $t6, $t6, 4
	add $t6, $t6, $t0
	lw $a1 0($t6)

	#Second element to be swapped

	add $t7, $s3, $t1
	mul $t7, $t7, 4
	add $t7, $t7, $t0
	lw $a2 0($t7)
	
	sw $a1, 0($t7)
	sw $a2, 0($t6)
	
	addi $t1, $t1, 1
	b Rswap
	
	exitRowSwap:
	jal print
	b exit
	
	colSwap:

	li $v0, 4
	la $a0, message7
	syscall
	
	li $v0, 5
	syscall
	
	move $a3, $v0
	
	li $v0, 4
	la $a0, message8
	syscall
	
	li $v0, 5
	syscall
	
	move $s3, $v0
		
	la $t0, matrix
	lw $t1, iterator
	
	Cswap:
	beq  $t1, 5, exitColSwap
	
	#Fisrt element to be swapped
	mul $t6, $t1, 5
	add $t6, $t6, $a3
	mul $t6, $t6, 4
	add $t6, $t6, $t0
	lw $a1 0($t6)

	#Second element to be swapped
	mul $t7, $t1, 5	
	add $t7, $t7, $s3
	mul $t7, $t7, 4
	add $t7, $t7, $t0
	lw $a2 0($t7)
	
	sw $a1, 0($t7)
	sw $a2, 0($t6)
	
	addi $t1, $t1, 1
	b Cswap
	
	exitColSwap:
	jal print
	
	exit:
	
	li $v0, 10
	syscall
	
	print:
	#printing all numbers
	li $v0, 4
	la $a0, message2
	syscall
	
	la $t0, matrix
	lw $t1, iterator
	lw $t2, size
	addi $t3, $zero, 0
	addi $t4, $zero, 0
	
	printLoop:
	bge $t1, $t2, exitPrint
	
	addu $t3, $t3, $t0
	
	li $v0, 1
	lw $a0, 0($t3)
	syscall
	
	li $v0, 4
	la $a0, space
	syscall
	
	addi $t4, $t4, 1
	blt $t4, 5, nextElement
	
	addi $t4, $zero, 0
	li $v0, 4
	la $a0, newline
	syscall
	nextElement:
	addi $t1, $t1, 1
	sll $t3, $t1, 2
	
	j printLoop
	exitPrint:
	jr $ra
	
