.data
    s1: .space 100
    s2: .space 100
    message:  	  .asciiz 	"Enter string: "
    mess_result:  .asciiz 	"Common characters of Strings: "
.text
main:	la	$t1, s1		# lưu địa chỉ chuỗi s1 để lưu nội dung chuỗi sẽ được nhập vào
   	jal	get_input 	# get_input($t1)-> yêu cầu nhập chuỗi từ bàn phím và lưu vào $t1
   	nop
   	add 	$s1, $t1, $0	# địa chỉ chuỗi s1 -> $s1 = $t1

	la	$t1, s2		# lưu địa chỉ chuỗi s1 để lưu nội dung chuỗi sẽ được nhập vào
   	jal	get_input 	# get_input($t1)-> yêu cầu nhập chuỗi từ bàn phím và lưu vào $t1
   	nop
   	add 	$s2, $t1, $0	# địa chỉ chuỗi s2 -> $s2 = $t1 

   	add	$a0, $s1, $0	# gán địa chỉ chuỗi s1($s1) vào $a0 để dùng hàm common_char
   	add	$a1, $s2,$0	# gán địa chỉ chuỗi s2($s2) vào $a1 để dùng hàm common_char
   	jal 	common_char	# common_char($a0, $a1) -> tìm các kí tự chung và lưu vào stack 
   	nop
   	
	jal	count_common	# count_common($a0, $a1, $k1) dem so lan lap cua cac ki tu chung
	nop
end_main:	li $v0, 10      # kết thúc chương trình
		syscall
		
#------------------------------------------------------------------------------
#------------------------------------------------------------------------------
# function get_input($t1)
# In thông báo và yêu cầu nhập chuỗi
# $t1: lưu địa chỉ của string để lưu chuỗi sẽ được nhập vào
#------------------------------------------------------------------------------
get_input: la $a0, message    	# Load và in ra thông báo yêu cầu nhập chuỗi
    	   li $v0, 4		# print string
    	   syscall
    		
   	   li $v0, 8       	# read string
	   add $a0, $t1, $0  	# lưu space của string ($t1) vào $a0
    	   li $a1, 100      	# độ dài lớn nhất của chuỗi nhập vào
    	   
    	   add $t1, $a0, $0   	# lưu dịa chỉ string vừa nhập vào $t1
    	   syscall
	   jr $ra		# kết thúc hàm và trở lại hàm main

#------------------------------------------------------------------------------
#------------------------------------------------------------------------------
# function common_char($a0, $a1)
# Tìm tất cả các kí tự chung của 2 chuỗi có địa chỉ lưu trong $a0, $a1
# $a1, $a0: địa chỉ của chuỗi đưa vào
# Trả về: $sp -> danh sách các kí tự chung
#	  $k1 -> số lượng kí tự chung
#------------------------------------------------------------------------------
common_char: 	li $t0, 0	# $t0 = i -> biến chạy

# loop1: Lặp qua các kí tự của string1 ($a0)
loop1:		add $t2, $a0, $t0	# t2 = a0 + i = address string1[i]
		lb $t3, 0($t2)		# t3 = string1[i]
		beq $t3, 10, end_common_char #  nếu là kí tự '\0' = 10 thi dừng vì hết chuỗi
		nop
		li $t1, 0	# $t1 -> j biến chạy vòng lặp 2
		
# loop2: với mỗi kí tự đọc từ string1($a0) , so sánh lần lượt với các kí tự string2 ($a1)
#	nếu kí tự là chung thì push vào stack, nếu không trùng tiếp tục đến kí tự tiếp theo ở string1
#	là vòng lặp lồng trong loop1
loop2:		add $t4, $a1, $t1		# t4 = a1 + j = address string2[j]
		lb $t5, 0($t4)			# t5 = string2[j]
		beq $t5, 10, countinue_loop1	# nếu là kí tự '\0' = 10 thi dừng vì hết chuỗi
		nop
		beq $t3, $t5, push_to_stack	# nếu string1[i] == string2[j] -> push vào stack
		nop

		addi $t1,$t1,1			# j++
		j loop2

countinue_loop1:	addi $t0, $t0, 1	# i++
			j loop1

end_common_char: 	jr $ra

#------------------------------------------------------------------------------
# push_to_stack($t3)
# Kiểm tra giá trị trong thanh ghi $t3 đã tồn tại trong stack hay chưa.
#	Nếu chưa tồn tại -> push vào stack
#	Nếu đã tồn tại -> dừng và trở lại lopp1 để đọc tiếp kí tự
# $t3: lưu giá trị của kí tự cần push vào stack
# $k1: số lượng phần tử hiện tại của stack
#------------------------------------------------------------------------------
push_to_stack:	li $t6, 0		# biến chạy $t6: k = 0 

# check_loop: duyệt stack và kiểm tra xem $t3 đã có trong stack hay chưa? 
check_loop:	beq $t6, $k1, push 	# nếu $t6 = $k1 -> duyệt hết stack -> chưa có trong stack -> push
		nop
		
		sll $t7, $t6, 2  		# $t7 = $t6 * 4
		add $t7, $t7, $sp 		# $t7 = $sp + k*4 = address phần tử thứ k của stack
		lb $t8, 0($t7)			# $t8 lưu phần tử thứ k của stack
		beq $t8, $t3, countinue_loop1 	# neu $t8 = $t3 ->  $t3 đã tồn tại -> không push -> thoát và quay lại vòng lặp ngoài
		nop

		addi $t6, $t6, 1 		# k++
		j check_loop

# push: lưu giá trị của kí tự $t3 vào stack $sp
push: 		addi $sp, $sp, -4	# để dành một phần tử trong stack
		sw   $t3, 0($sp)	# lưu $t3 vào vị tí nói trên 
		addi $k1, $k1, 1	# cập nhật phần tử của stack $k1++
		j countinue_loop1

#------------------------------------------------------------------------------
#------------------------------------------------------------------------------
# function count_common($a0, $a1, $sp)
# Đếm các số lần lặp của kí tự chung của 2 chuỗi và in ra kết quả
# 	$a1, $a0: địa chỉ của chuỗi đưa vào
# 	$sp -> stack các kí tự chung
#	$k1 -> số lượng kí tự chung hay số lượng hiện tại của stack
# Trả về kết quả lưu trong: $s7
#------------------------------------------------------------------------------
count_common:	li $t1, 0	 # biến lặp i = 0
		add $t9, $ra, $0 # lưu địa chỉ trả về $t9 = $ra

# loop_stack: duyệt các phần tử của stack 
loop_stack:	beq $t1, $k1, print_result 	# nếu i == số lượng phần tử stack -> dừng và in kết quả
		nop

		sll $t2, $t1, 2  	# t2 = t1 * 4 = 4i
		add $t2, $t2, $sp 	# t2 = sp + i*4 = address phần tử thứ i của stack
		lb $s3, 0($t2)		# load phần tử thứ i của Stack vào $s3
		

		add $a2, $s1, $0 	# gán địa chỉ string s1(đang lưu trong $s1) vao $a2 để dùng hàm count_in_string
		jal count_in_string	# count_in_string($s3, $a2) đếm số kí tự $s3 trong string $a2		
		nop			# return kết quả ra $k0

		add $s5, $k0, $0 	# gán count vừa tìm được trong string s1 vao $s5

		add $a2, $s2, $0	# gán địa chỉ string s2(đang lưu trong $s2) vao $a2 để dùng hàm count_in_string
		jal count_in_string	

		add $s6, $k0, $0 	# gán count vừa tìm được trong string s2 vao $s6

# result: so sánh $s5, $s6 lấy giá trị nhỏ hơn và cộng dần vào kết quả $s7
result:		slt  $t3, $s5, $s6	# nếu $s5 < $s6 -> đúng $t3 = 1, ngược lại $t3 = 0
		beqz $t3, update	# nếu $t3 = 0 -> $s6 < $s5 cập nhật $s7 bằng $s6 

		add $s7, $s7, $s5	# TH $t3 = 1 -> $s5 < $s6 -> cập nhật $s7

countinue_loop:	addi $t1, $t1, 1 	# i++
		j loop_stack		# tiếp tục lòng lặp các kí tự đang chứa trong stack

# printf_result: in ra màn hình kết quả được lưu trong $s7
print_result: 	li, $v0, 4		# In String
		la $a0, mess_result
		syscall

		li $v0, 1		# In ra Integer
		add $a0, $s7, $0
		syscall
		
		add $ra, $t9, $0 	# Khôi phục địa chỉ trả về $ra = $t9 -> Thoát ra main
		jr $ra

# update: cập nhật $s7 bằng $s6 
update:		add $s7, $s7, $s6

		j countinue_loop

#------------------------------------------------------------------------------
# function count_in_string($s3, $a2) đếm số kí tự $s3 trong string $a2
# 	$s3 -> chứa kí tự cần đếm trong $a2
# 	$a2: địa chỉ của chuỗi đưa vào
#	$k1 -> số lượng kí tự chung hay số lượng hiện tại của stack
# Trả về: $k0 -> chứa count tìm được
#------------------------------------------------------------------------------
count_in_string:	li $t3, 0 	# biến chạy i = 0
			li $k0, 0 	# khởi tạo $k0 = 0 (count = 0)
			
# loop_string: duyệt string và tăng đếm $k0 nếu có kí tự trùng với $s3
loop_string:		add $t4, $a2, $t3	# $t4 = $a2 + i = address string[i]
			lb $t5, 0($t4)		# $t5 chứa giá trị string[i]
			
			beq $t5, 10, end_count_in_string	# nếu kí tự là '\0' -> dừng lặp string -> thoát hàm

			bne $s3, $t5, countinue_count 		# Nếu kí tự dang duyệt = kí tự $s3 -> tăng count $k0 
								# -> ngược lại tiếp tục duyệt đến kí tự tiếp theo

			addi $k0, $k0,1 			# count++

countinue_count:	addi $t3, $t3,1 	# i++
			j loop_string

end_count_in_string: 	jr $ra	# Thoát ra hàm count_common
