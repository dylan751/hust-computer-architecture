#Laboratory Exercise 10 Home Assignment 2 
.eqv MONITOR_SCREEN 	0x10010000  # dia chi bat dau cua bo nho man hinh
.eqv RED	 	0x00FF0000  # cac dia chi mau thuong su dung 
.eqv GREEN		0x0000FF00
.eqv WHITE		0x00FFFFFF
.eqv YELLOW		0x00FFFF00

.data 
	arr1 : .word	0x00FFFFFF, 0x00FF0000, 0x00FF0000, 0x00FF0000, 0x00FF0000, 0x00FFFFFF, 0x00FFFFFF, 0x00FFFFFF
	arr2 : .word	0x00FFFFFF, 0x00FF0000 0x00FFFFFF, 0x00FFFFFF, 0x00FFFFFF, 0x00FF0000, 0x00FFFFFF, 0x00FFFFFF
	arr3 : .word	0x00FFFFFF, 0x00FF0000, 0x00FFFFFF, 0x00FFFFFF, 0x00FFFFFF, 0x00FFFFFF, 0x00FF0000, 0x00FFFFFF
	arr4 : .word	0x00FFFFFF, 0x00FF0000, 0x00FFFFFF, 0x00FFFFFF, 0x00FFFFFF, 0x00FFFFFF, 0x00FF0000, 0x00FFFFFF
	arr5 : .word	0x00FFFFFF, 0x00FF0000, 0x00FFFFFF, 0x00FFFFFF, 0x00FFFFFF, 0x00FFFFFF, 0x00FF0000, 0x00FFFFFF
	arr6 : .word	0x00FFFFFF, 0x00FF0000, 0x00FFFFFF, 0x00FFFFFF, 0x00FFFFFF, 0x00FFFFFF, 0x00FF0000, 0x00FFFFFF
	arr7 : .word	0x00FFFFFF, 0x00FF0000, 0x00FFFFFF, 0x00FFFFFF, 0x00FFFFFF, 0x00FF0000, 0x00FFFFFF, 0x00FFFFFF
	arr8 : .word	0x00FFFFFF, 0x00FF0000, 0x00FF0000, 0x00FF0000, 0x00FF0000, 0x00FFFFFF, 0x00FFFFFF, 0x00FFFFFF
.text	
main:	li $k0, MONITOR_SCREEN	   # nap dia chi bat dau cua man hinh
	li $t2, 0
	
	la $a0, arr1
	jal print_line
	nop
	
	la $a0, arr2
	jal print_line
	nop
	
	la $a0, arr3
	jal print_line
	nop
	
	la $a0, arr4
	jal print_line
	nop
	
	la $a0, arr5
	jal print_line
	nop
	
	la $a0, arr6
	jal print_line
	nop
	
	la $a0, arr7
	jal print_line
	nop
	
	la $a0, arr8
	jal print_line
	nop
	
end_main:	li $v0 , 10
	 	syscall

	
print_line:	li $t1, 0
loop:	beq	$t1, 32, end

	add	$t3, $k0, $t2	# $k0 + t2*4 = $t3
	add	$t4, $a0, $t1	# $a0 + t1*4   = $t4
	
	lw	$t0, 0($t4)
	
	sw	$t0, 0($t3)
	nop
	
	addi $t1, $t1, 4
	addi $t2, $t2, 4
	j loop
end:	jr $ra

