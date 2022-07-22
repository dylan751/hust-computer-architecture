.data
ln1: .asciiz 	"                                                *************     \n"
ln2: .asciiz 	"**************                                 *3333333333333*    \n"
ln3: .asciiz 	"*222222222222222*                              *33333********     \n"
ln4: .asciiz 	"*22222******222222*                            *33333*            \n"
ln5: .asciiz 	"*22222*      *22222*                           *33333********     \n"
ln6: .asciiz 	"*22222*       *22222*       *************      *3333333333333*    \n"
ln7: .asciiz 	"*22222*       *22222*     **11111*****111*     *33333********     \n"
ln8: .asciiz 	"*22222*       *22222*   **1111**       **      *33333*            \n"
ln9: .asciiz 	"*22222*      *222222*   *1111*                 *33333********     \n"
ln10: .asciiz 	"*22222*******222222*   *11111*                 *3333333333333*    \n"
ln11: .asciiz 	"*2222222222222222*     *11111*                  *************     \n"
ln12: .asciiz 	"***************        *11111*                                    \n"
ln13: .asciiz 	"       ---              *1111**                                   \n"
ln14: .asciiz 	"     / o o \             *1111****   *****                        \n"
ln15: .asciiz 	"     \  >  /              **111111***111*                         \n"
ln16: .asciiz 	"      -----                 ***********        dce.hust.edu.vn    \n"

menu: .asciiz "\n\n============Menu============\n1.In anh ra man hinh\n2.Loai bo mau cua chu\n3.Doi vi tri thanh ECD\n4.Doi mau chu\n5.Exit.\nLua chon:"
invalid_choice: "\nNhap lai lua chon!\n"
input_D: .asciiz "\nNhap mau moi cho chu D: "
input_C: .asciiz "\nNhap mau moi cho chu C: "
input_E: .asciiz "\nNhap mau moi cho chu E: "
invalid_color: "\nMa mau khong hop le!\n\n"
.text
main:	
	jal print_menu			# In ra menu chuong trinh
	nop

	li $v0, 5			# Nhan vao input tu ban phim
	syscall
	
	beq $v0, 1, option_1		# Chay ham 1
	nop
	
	beq $v0, 2, option_2		# Chay ham 2
	nop
	
	beq $v0, 3, option_3		# Chay ham 3
	nop
	
	beq $v0, 4, option_4		# Chay ham 4
	nop
	
	beq $v0, 5, end_main		# Ket thuc chuong trinh
	nop
	
	la $a0, invalid_choice
	li $v0, 4
	syscall
	
end_main:	li $v0, 10
		syscall
#------------------------------------------------------------------------------
# function print_image
# thực hiện in 16 chuỗi kí tự tương ứng 16 dòng của ảnh
#------------------------------------------------------------------------------
print_image:			# In ra tung dong (ln1 -> ln16)
	la $a0, ln1
	li $v0, 4
	syscall
	
	la $a0, ln2
	li $v0, 4
	syscall 
	
	la $a0, ln3
	li $v0, 4
	syscall 
	
	la $a0, ln4
	li $v0, 4
	syscall 
	
	la $a0, ln5
	li $v0, 4
	syscall 
	
	la $a0, ln6
	li $v0, 4
	syscall 
	
	la $a0, ln7
	li $v0, 4
	syscall 
	
	la $a0, ln8
	li $v0, 4
	syscall 
	
	la $a0, ln9
	li $v0, 4
	syscall 
	
	la $a0, ln10
	li $v0, 4
	syscall 
	
	la $a0, ln11
	li $v0, 4
	syscall 
	
	la $a0, ln12
	li $v0, 4
	syscall 
	
	la $a0, ln13
	li $v0, 4
	syscall 
	
	la $a0, ln14
	li $v0, 4
	syscall 
	
	la $a0, ln15
	li $v0, 4
	syscall
	
	la $a0, ln16
	li $v0, 4
	syscall 
end_print: jr $ra

#------------------------------------------------------------------------------
# printf_menu()
# In chuỗi chứa thông tin của menu ở biến menu
#------------------------------------------------------------------------------
print_menu:
	la $a0, menu
	li $v0, 4
	syscall
	
	j end_print
#------------------------------------------------------------------------------
# Các option của chương trình chính
#------------------------------------------------------------------------------
option_1:
	jal print_image		# In 16 dong tu ln1 -> ln16
	nop
end_option: j end_main		# Ket thuc chuong trinh

# Duyet tung dong -> Xoa tat ca ky tu '0' -> '9' cua dong do
option_2:
	la $k0, ln1
	jal remove_color
	nop

	la $k0, ln2
	jal remove_color
	nop

	la $k0, ln3
	jal remove_color
	nop
	
	la $k0, ln4
	jal remove_color
	nop
	
	la $k0, ln5
	jal remove_color
	nop
	
	la $k0, ln6
	jal remove_color
	nop
	
	la $k0, ln7
	jal remove_color
	nop
	
	la $k0, ln8
	jal remove_color
	nop
	
	la $k0, ln9
	jal remove_color
	nop
	
	la $k0, ln10
	jal remove_color
	nop
	
	la $k0, ln11
	jal remove_color
	nop
	
	la $k0, ln12
	jal remove_color
	nop
	
	la $k0, ln13
	jal remove_color
	nop
	
	la $k0, ln14
	jal remove_color
	nop
	
	la $k0, ln15
	jal remove_color
	nop
	
	j option_1
	
# Duyet tung dong -> Thay cot 1 voi cot 3 -> thay E voi D
option_3:la $k0, ln1
	jal ECD
	nop
	
	la $k0, ln2
	jal ECD
	nop
	
	la $k0, ln3
	jal ECD
	nop	
	
	la $k0, ln4
	jal ECD
	nop	
	
	la $k0, ln5
	jal ECD
	nop	
	
	la $k0, ln6
	jal ECD
	nop	
	
	la $k0, ln7
	jal ECD
	nop	
	
	la $k0, ln8
	jal ECD
	nop	
	
	la $k0, ln9
	jal ECD
	nop	
	
	la $k0, ln10
	jal ECD
	nop	
	
	la $k0, ln11
	jal ECD
	nop	
	
	la $k0, ln12
	jal ECD
	nop	
	
	la $k0, ln13
	jal ECD
	nop	
	
	la $k0, ln14
	jal ECD
	nop	
	
	la $k0, ln15
	jal ECD
	nop	
	
	la $k0, ln16
	jal ECD
	nop
	
	j option_1
	
# $s1 luu gia tri cua D
# $s2 luu gia tri cua C
# $s3 luu gia tri cua E
option_4:
	la $a0, input_D
	li $v0, 4
	syscall
	li $v0, 12
	syscall
	add $s1, $v0, $0
	add $t1, $v0, $0	# Tham so dau vao cua ham check_color, de check ma mau` hop le khong
	jal check_color
	nop
	
	la $a0, input_C
	li $v0, 4
	syscall
	li $v0, 12
	syscall
	add $s2, $v0, $0
	add $t1, $v0, $0	# Tham so dau vao cua ham check_color, de check ma mau` hop le khong
	jal check_color
	nop
	
	la $a0, input_E
	li $v0, 4
	syscall
	li $v0, 12
	syscall
	add $s3, $v0, $0
	add $t1, $v0, $0	# Tham so dau vao cua ham check_color, de check ma mau` hop le khong
	jal check_color
	nop
	
	# change_color: Ham duyet tung dong ->
	# thay tat ca cot 1 thanh` $s1
	# thay tat ca cot 2 thanh` $s2
	# thay tat ca cot 3 thanh` $s3
	la $k0, ln1
	jal change_color
	nop
	
	la $k0, ln2
	jal change_color
	nop
	
	la $k0, ln3
	jal change_color
	nop
	la $k0, ln4
	jal change_color
	nop
	
	la $k0, ln5
	jal change_color
	nop
	la $k0, ln6
	jal change_color
	nop
	
	la $k0, ln7
	jal change_color
	nop
	la $k0, ln8
	jal change_color
	nop
	
	la $k0, ln9
	jal change_color
	nop
	la $k0, ln10
	jal change_color
	nop
	
	la $k0, ln11
	jal change_color
	nop
	la $k0, ln12
	jal change_color
	nop
	
	la $k0, ln13
	jal change_color
	nop
	
	la $k0, ln14
	jal change_color
	nop
	
	la $k0, ln15
	jal change_color
	nop
	
	la $k0, ln16
	jal change_color
	nop
	
	la $a0, '\n'
	li $v0, 12
	syscall
	
	j option_1
#------------------------------------------------------------------------------
#$k0 tham so dong dau vao
#Duyet -> xoa tat ca ky tu '0' < x < '9'
#------------------------------------------------------------------------------
remove_color: 	li $a1, 0			# Bien dem
loop_find_color:add $k1, $k0, $a1
	   	lb $t1, 0($k1)
	   	beq $t1, '\n', end_remove	# Gap ky tu xuong dong -> ket thuc ham`
	   	nop
	  	blt $t1, '0', skip		# < '0' -> Bo qua
	  	nop
    	   	bgt $t1, '9', skip		# > '9' -> Bo qua
    	   	nop
    	   	
    	   	la $t1, ' '			# Thay ky tu thanh` ' ' -> ~ xoa
    	   	sb $t1, 0($k1)
skip: 	add $a1, $a1, 1				# Tang bien dem len 1
	j loop_find_color
end_remove: jr $ra
#-------------------------------------------------
# ECD -> đổi vị trí trong ảnh đẻ thay đồi từ DCE -> ECD
# Chia 3 ảnh và đổi vị trí các kí tự ở 1/3 dầu và 1/3 cuối
#-------------------------------------------------
ECD:	li $a1, 0	# 0->20 -> chu D, 21: dau cach 
			# 22-> 42 -> chữ C, 43: dau cach
			# 43-> 63 -> chữ E, 64: dau cach
			# 65-> \n
loop_ECD: 
	beq $a1, 21, end_ECD	# Gap ' ' -> ket thuc ham
	nop
	
	add $a2, $a1, 44 #E
	   
	add $s1, $k0, $a1 # D
	add $s2, $k0, $a2 # E
	  
	  
	# Dao vi tri cot 1 voi cot 3 (dao vi tri D voi E)
	lb $t1, 0($s1) #D
	lb $t2, 0($s2) #E
	
	sb $t1, 0($s2)
	sb $t2, 0($s1)  
	
	addi $a1, $a1, 1	# Tang bien dem len 1
	j loop_ECD 
end_ECD: jr $ra

#-------------------------------------------------
# change_color($s1, $s2, $s3)
# $s1, $s2, $s3 chứa giá trị 3 màu tương ứng D, C, E
# Ham thay doi mau sac
#-------------------------------------------------
change_color:li $a1, 0		# Bien dem

# lặp đến hết chữ D và thay màu bằng màu $s1
loop_fnd_color:
		beq $a1, 21, next_letter2	# 0->20 -> chu D, 21: dau cach 
		
		add $k1, $k0, $a1
	   	lb $t1, 0($k1)			# Lay ra ki tu mau hien tai
	   	
	   	nop
	  	blt $t1, '0', skip_char		# < '0' -> khong phai mau -> Skip
	  	nop
    	   	bgt $t1, '9', skip_char		# > '9' -> khong phai mau -> Skip
    	   	nop
    	   	
    	   	add $t1, $0, $s1		# Thay mau` bang ki tu $s1
    	   	sb $t1, 0($k1)			# Luu mau` vao chu D
    	   	
skip_char: 	add $a1, $a1, 1			# Tang bien dem len 1
		j loop_fnd_color
		add $a1, $a1, 1
		
# lặp đến hết chữ C và thay màu bằng màu $s2
next_letter2:
		beq $a1, 43, next_letter3	# 22-> 42 -> chữ C, 43: dau cach
		add $k1, $k0, $a1
	   	lb $t1, 0($k1)			# Lay ra ki tu mau hien tai
	   	
	   	nop
	  	blt $t1, '0', skip_char2	# < '0' -> khong phai mau -> Skip
	  	nop
    	   	bgt $t1, '9', skip_char2	# > '9' -> khong phai mau -> Skip
    	   	nop
    	   	
    	   	add $t1, $0, $s2		# Thay mau` bang ki t $s2
    	   	sb $t1, 0($k1)			# Luu mau` vao chu C
skip_char2: 	add $a1, $a1, 1			# Tang bien dem len 1
		j next_letter2
		add $a1, $a1, 1
# lặp đến hết chữ E và thay màu bằng màu $s3
next_letter3:
		beq $a1, 65, end_change		# 43-> 63 -> chữ E, 64: dau cach. 65: '\n'
		add $k1, $k0, $a1
	   	lb $t1, 0($k1)			# Lay ra ki tu mau hien tai
	   	
	   	nop
	  	blt $t1, '0', skip_char3	# < '0' -> khong phai mau -> Skip
	  	nop
    	   	bgt $t1, '9', skip_char3	# > '9' -> khong phai mau -> Skip
    	   	nop
    	   	
    	   	add $t1, $0, $s3		# Thay mau` bang ki tu $s3
    	   	sb $t1, 0($k1)			# Luu mau` vao chu E
skip_char3: 	add $a1, $a1, 1			# Tang bien dem len 1
		j next_letter3	
end_change: jr $ra


check_color:
	blt $t1, '0', invalid			# < '0' -> khong phai mau -> loi
	nop
    	bgt $t1, '9', invalid			# > '9' -> khong phai mau -> loi
    	nop
end_check: jr $ra
invalid:
	li $v0, 4
	la $a0, invalid_color			# In ra loi invalid_color
	syscall
	
	j end_main
