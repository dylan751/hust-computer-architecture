#Laboratory Exercise 5, Home Assignment 3
.data
test: .word 3,6,2,1
.text
main:
la $a0,test
li $a1,4
jal sort
nop
la $a0,test
lw $s0,0($a0) #load test array after sorting
lw $s1,4($a0)
lw $s2,8($a0)
lw $s3,12($a0)
end_main:
swap:
sll $t1,$a1,2 #reg $t1=k*4
add $t1,$a0,$t1 #reg $t1=v+(k*4)
#reg $t1 has the address of v[k]
lw $t0,0($t1) #reg $t0 (temp)=v[k]
lw $t2,4($t1) #reg $t2=v[k+1]
#refers to next element of v
sw $t2,0($t1) #v[k]=reg $t2
sw $t0,4($t1) #v[k+1]=reg $t0 (temp)
jr $ra
end_swap:
#Procedure sort
#function: sort a list of element ascending
sort:
addi $sp,$sp,-20 #make room on stack for 5 registers
sw $ra,16($sp) #save ra
sw $s3,12($sp) #save $s3
sw $s2,8($sp) #save $s2
sw $s1,4($sp) #save $s1
sw $s0,0($sp) #save $s0
move $s2,$a0 #copy parameter $$a0 into $s2 (save $a0)
move $s3,$a1 #copy parameter $a1 into $s3 (save a1)
move $s0,$zero #i=0
for1tst:
slt $t0,$s0,$s3 #reg $t0=0 if $s0>=s3 (i>=n)
beq $t0,$zero,exit1 #go to exit1 if $s0>=s3 (i>=n)
addi $s1,$s0,-1 #j=i-1
for2tst:
slti $t0,$s1,0 #reg $t0=1 if $s1<0 (j<0)
bne $t0,$zero,exit2 #go to exit2 if $s1<0 (j<0)
sll $t1,$s1,2 #reg $t1=j*4
add $t2,$s2,$t1 #reg $t2=v+(j*4)
lw $t3,0($t2) #reg $t3=v[j]
lw $t4,4($t2) #reg $t4=v[j+1]
slt $t0,$t4,$t3 #reg $t0=0 if $t4>=t3
beq $t0,$zero,exit2 #go to exit2 if $t4>=t3
move $a0,$s2 #1st parameter of swap is v(old $a0)
move $a1,$s1 #2nd parameter of swap is j
jal swap
addi $s1,$s1,-1 #j=j-1
j for2tst #jump to test of inner loop
exit2:
addi $s0,$s0,1 #i=i+1
j for1tst #jump to test of outer loop
exit1:
lw $s0,0($sp) #restore $s0
lw $s1,4($sp) #restore $s1
lw $s2,8($sp) #restore $s2
lw $s3,12($sp) #restore $s3
lw $ra,16($sp) #restore ra
addi $sp,$sp,20 #restore stack pointer
jr $ra
