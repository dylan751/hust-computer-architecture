.data
message_input: .asciiz "Enter ticket number: "

invalid_big: 	  .asciiz	"Number is too big!" 
invalid_negative: .asciiz	"Number is negative!"
invalid_odd: 	  .asciiz	"Number of digits is odd!" 

lucky: .asciiz	"Lucky number"
not_lucky: .asciiz "Not lucky number"

.text
main: 	li $v0, 4		# in thông báo nhận đầu vào
	la $a0, message_input
	syscall
	
	li $v0, 5 		# Đọc số n nhập từ bàn phím 
	syscall
	add $s0, $v0, $0 	# Lưu giá trị n -> s0

	jal check_input 	# check_input -> kiểm tra đầu vào n
	nop

	jal is_lucky 		# is_lucky -> kiểm tra xem n lucky hay không và in kết quả
	nop
	
end_main: 	li $v0, 10	# kết thúc chương trình
		syscall
#------------------------------------------------------------------------------
# function error($a1)
# In thông báo lỗi
# $a1: lưu địa chỉ của string chứa nội dung lỗi
#------------------------------------------------------------------------------
error:	li $v0, 4
	add $a0, $a1, $0
	syscall
	j end_main
	
#------------------------------------------------------------------------------
# function result($a1)
# In thông báo kết quả, là hàm con trong is_lucky
# $a1: lưu địa chỉ của string chứa nội dung kết quả
#------------------------------------------------------------------------------	
result:	li $v0, 4
	add $a0, $a1, $0
	syscall

	j end_is_lucky
#------------------------------------------------------------------------------
# function check_input($s0)
# Kiểm tra số n nhập vào thỏa mãn điều kiện đầu vào hay không
# Các lỗi kiểm tra: số quá lớn, số âm, số chữ số của số là lẻ
# Đồng thời push các chữ số vào stack với con trỏ $sp
# $s0: chứa giá trị n
# Trả về: $k0 -> số chữ số của n
#	  $k1 -> Một nửa số chữ số của n (1/2 của $k0)
#------------------------------------------------------------------------------
check_input: 	add  $s1, $s0, $0 	# $s1 = $s0 = n
		li   $t2, 1000000000	# 1.000.000.000 -> giới hạn của n
		
# check_big -> kiểm tra n ($s1) < 1.000.000.000 hay không
check_big:	slt  $t1, $s1, $t2 	# Nếu n($s1) < 1.000.000.000 ? t1 = 1 ngược lại t1 = 0

		la   $a1, invalid_big	# gán địa chỉ string chứa lỗi vào $a1 để sử dụng hàm error
		beqz $t1, error		# in lỗi nếu t1 = 0 ( hay n > 1.000.000.000 )
		
# check_negative -> kiểm tra n là số âm hay không		
check_negative:	slt  $t1, $0, $s1 		# kiểm tra 0 < n($s1) ? t1 = 1 : t1 = 0

		la   $a1, invalid_negative	# gán địa chỉ string chứa lỗi vào $a1 để sử dụng hàm error 
		beqz $t1, error			# in lỗi nếu t1 = 0 ( hay n < 0 )
		
# check_odd -> kiểm tra số chữ số của n chẵn hay lẻ				
check_odd:	addi $t1, $0, 10  	# $t1 = 10 -> dùng làm số chia để tách các chữ số

# loop -> chia n dần cho 10 và gán lại n bằng thương và số dư push dần vào stack
# Vòng lặp dừng khi n = 0 -> hết chữ số
# $k0 đếm số chữ số	
loop:		beq $s1, 0, countinue_check 	# if ($s1) == 0 -> dừng loop
		nop		      		

		divu $s1, $t1 		# chia n cho 10 lấy thương và số dư ở lo, hi
		mfhi $t2		# số dư ở hi được lưu vào $t2 = n % 10
		mflo $t3		# thương ở lo được lưu vào $t3 = n / 10
		add  $s1, $t3, $0	# n($s1) = n / 10 = $t3  
		
# push: push chữ số hay số dư vừa tìm được vào stack
push:		addi $sp, $sp, -4 	# dành stack cho một phần tử
		sw   $t2, 0($sp)	# lưu số dư hay các chữ cái của n vào stack
		add  $k0, $k0, 1   	# tăng biến đếm $k0 ++
		j loop
		
# countinue_check -> sau khi dừng vòng lặp, tiếp tục kiểm tra số chữ số lẻ hay không (kiểm tra $k0 chia hết cho 2)
countinue_check:addi $t4, $0, 2		# gán t4 = 2 -> làm số chia

		div  $k0, $t4		# chia $k0 cho 2 -> thương và dư lưu ở lo, hi
		mfhi $t4		# lấy số dư từ hi lưu vào $t4
		mflo $k1		# thương là 1/2 số chữ số của n lưu vào $k1
		
		la   $a1, invalid_odd   # gán địa chỉ string chứa lỗi vào $a1 để sử dụng hàm error
		bne  $t4, 0, error	# nếu không chia hết hay số dư ($t4) khác 0 -> báo lỗi bằng hàm error
		nop
		
		jr $ra			# thoát hàm check_input trở về hàm main
		
#------------------------------------------------------------------------------
# function is_lucky($sp, $k1)
# Kiểm tra tổng nữa đầu và nửa sau của các chữ số của n (lucky) và in kết quả qua hàm result
# Duyệt nửa stack đầu và tính tổng, tương tự với nửa sau
# So sánh 2 tổng và đưa ra kết luận
# $sp -> stack chứa các chữ số của n
# $k1 -> 1/2 số chữ số của n hay 1/2 số phần tử của stack
#------------------------------------------------------------------------------
is_lucky: addi $t1, $0, 0	# i = 0 -> biến chạy vòn lặp nửa đầu
	  addi $t2, $0, 0	# j = 0 -> biến chạy vòn lặp nửa sau
	  add $s2, $0, $0	# $s2 lưu sum của nửa đầu
	  add $s3, $0, $0	# $s3 lưu sum của nửa sau

# loop1: tính tổng nửa đầu của stack 
loop1:	beq	$t1, $k1, loop2		# nếu i($t1) == $k0 -> dừng vòng lặp -> đi đến tính tổng nửa sau
	nop
# pop1: lấy phần tử trong stack ra để cộng dần vào $s2 để tính tổng
pop1:	lw 	$t3, 0($sp) 	# pop chữ ra khỏi stack vào $t3
	addi 	$sp, $sp, 4 	# xoá 1 mục ra khỏi stack
	
	add 	$s2, $s2, $t3	# tính tổng ($s2) += $t3 (chữ số vừa pop ra)
	addi 	$t1, $t1, 1	# tăng biến đếm để lặp i++
	j 	loop1
	
# loop2: tính tổng nửa sau của stack 
loop2:	beq	$t2, $k1, check_lucky	# nếu i($t1) == $k0 -> dừng vòng lặp -> đi đến so sánh 2 tổng ở check_lucky
	nop
# pop1: lấy phần tử trong stack ra để cộng dần vào $s3 để tính tổng
pop2:	lw 	$t3, 0($sp) 	# pop và lưu vào $t3
	addi 	$sp, $sp, 4 	# xóa 1 mục ra khỏi stack
	
	add 	$s3, $s3, $t3	# tính tổng ($s3) += $t3
	addi 	$t2, $t2, 1	# tăng biến đếm để lặp j++
	j 	loop2
# check_lucky -> kiểm tra tổng 2 nửa có bằng nhau hay không
check_lucky: 	la $a1, not_lucky	# lưu địa chỉ thông báo vào $a1 để sử dụng hàm result
		bne $s2, $s3, result	# nếu 2 nửa không bằng nhau in thông báo not_lucky
		nop			# ngược lại -> lucky
		la $a1, lucky		# lưu địa chỉ thông báo vào $a1 để sử dụng hàm result
		j  result		
end_is_lucky:	jr $ra			# kết thúc hàm is_lucky trở về hàm main
