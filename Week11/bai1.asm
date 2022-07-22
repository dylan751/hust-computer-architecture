.eqv IN_ADRESS_HEXA_KEYBOARD 0xFFFF0012
.eqv OUT_ADRESS_HEXA_KEYBOARD 0xFFFF0014


.text
main: 
	li $t1, IN_ADRESS_HEXA_KEYBOARD
 	li $t2, OUT_ADRESS_HEXA_KEYBOARD
 	
 	
start_polling_1:
	li $t3, 0x01 # check row 1 with key 0, 1, 2, 4
	sb $t3, 0($t1) # must reassign expected row
	jal polling

start_polling_2:
	li $t3, 0x02 # check row 2 with key 4, 5, 6, 7
	sb $t3, 0($t1) # must reassign expected row
	jal polling

start_polling_3:
	li $t3, 0x04 # check row 3 with key 8, 9, A, B
	sb $t3, 0($t1) # must reassign expected row
	jal polling
 	
start_polling_4:
 	li $t3, 0x08 # check row 4 with key C, D, E, F
 	sb $t3, 0($t1) # must reassign expected row
 	jal polling

check_after_polling_4:
	beq $a0, 0x0, print
 	j start_polling_1
 	
polling: 
 	lb $a0, 0($t2) # read scan code of key button
 	bne $a0, 0x0, print
 	jr $ra
 	
print: 
	li $v0, 34 # print integer (hexa)
 	syscall
 	
sleep: 
	li $a0, 100 # sleep 100ms
 	li $v0, 32
 	syscall
 	
back_to_start_polling: 
	j start_polling_1	# back to check row 1
