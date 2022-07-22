.eqv KEY_CODE 0xFFFF0004 # ASCII code from keyboard, 1 byte
.eqv KEY_READY 0xFFFF0000 # =1 if has a new keycode ?
# Auto clear after lw
.eqv DISPLAY_CODE 0xFFFF000C # ASCII code to show, 1 byte
.eqv DISPLAY_READY 0xFFFF0008 # =1 if the display has already to do
# Auto clear after sw

.text
li $k0, KEY_CODE
li $k1, KEY_READY



li $s0, DISPLAY_CODE
li $s1, DISPLAY_READY



loop:
nop



WaitForKey:
lw $t1, 0($k1) # $t1 = [$k1] = KEY_READY
nop
beq $t1, $zero, WaitForKey # if $t1 == 0 then Polling
nop

#-----------------------------------------------------
ReadKey:
lw $t0, 0($k0) # $t0 = [$k0] = KEY_CODE
nop

#-----------------------------------------------------
WaitForDis:
lw $t2, 0($s1) # $t2 = [$s1] = DISPLAY_READY
beq $t2, $zero, WaitForDis # if $t2 == 0 then Polling
nop
#-----------------------------------------------------
ShowKey:
add $t2, $t0, $0
addi $t0, $t0, 0 # Because my last digits of student number is 0
sw $t0, 0($s0) # show key



# Kiem tra D
CheckD:
beq $t2, 'd', Exit_CL # Neu la chu d thi dung lai
beq $t2, 'D', Exit_CL # Neu la chu D thi dung lai
j loop
#-------------------------------------------------------------------------------------------------



# Nếu là exit thì thoát chương trình
Exit_CL:
li $v0, 10
syscall