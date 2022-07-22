.data 

reg_0: .asciiz "$0" 

reg_zero: .asciiz "$zero" 

reg_1: .asciiz "$1" 

reg_at: .asciiz "$at" 

reg_2: .asciiz "$2" 

reg_v0: .asciiz "$v0" 

reg_3: .asciiz "$3" 

reg_v1: .asciiz "$v1" 

reg_4: .asciiz "$4" 

reg_a0: .asciiz "$a0" 

reg_5: .asciiz "$5" 

reg_a1: .asciiz "$a1" 

reg_6: .asciiz "$6" 

reg_a2: .asciiz "$a2" 

reg_7: .asciiz "$7" 

reg_a3: .asciiz "$a3" 

reg_8: .asciiz "$8" 

reg_t0: .asciiz "$t0" 

reg_9: .asciiz "$9" 

reg_t1: .asciiz "$t1" 

reg_10: .asciiz "$10" 

reg_t2: .asciiz "$t2" 

reg_11: .asciiz "$11" 

reg_t3: .asciiz "$t3" 

reg_12: .asciiz "$12" 

reg_t4: .asciiz "$t4" 

reg_13: .asciiz "$13" 

reg_t5: .asciiz "$t5" 

reg_14: .asciiz "$14" 

reg_t6: .asciiz "$t6" 

reg_15: .asciiz "$15" 

reg_t7: .asciiz "$t7" 

reg_16: .asciiz "$16" 

reg_s0: .asciiz "$s0" 

reg_17: .asciiz "$17" 

reg_s1: .asciiz "$s1" 

reg_18: .asciiz "$18" 

reg_s2: .asciiz "$s2" 

reg_19: .asciiz "$19" 

reg_s3: .asciiz "$s3" 

reg_20: .asciiz "$20" 

reg_s4: .asciiz "$s4" 

reg_21: .asciiz "$21" 

reg_s5: .asciiz "$s5" 

reg_22: .asciiz "$22" 

reg_s6: .asciiz "$s6" 

reg_23: .asciiz "$23" 

reg_s7: .asciiz "$s7" 

reg_24: .asciiz "$24" 

reg_t8: .asciiz "$t8" 

reg_25: .asciiz "$25" 

reg_t9: .asciiz "$t9" 

reg_26: .asciiz "$26" 

reg_k0: .asciiz "$k0" 

reg_27: .asciiz "$27" 

reg_k1: .asciiz "$k1" 

reg_28: .asciiz "$28" 

reg_gp: .asciiz "$gp" 

reg_29: .asciiz "$29" 

reg_sp: .asciiz "$sp" 

reg_30: .asciiz "$30" 

reg_fp: .asciiz "$fp" 

reg_31: .asciiz "$31" 

reg_ra: .asciiz "$ra" 

 

# Lưu các tên thanh ghi ở trên vào mảng resgister  

registers:  

.word reg_0, reg_1, reg_2, reg_3, reg_4, reg_5, reg_6, reg_7, reg_8, reg_9, reg_10, reg_11, reg_12, reg_13, reg_14, reg_15 

.word reg_16, reg_17, reg_18, reg_19, reg_20, reg_21, reg_22, reg_23, reg_24, reg_25, reg_26, reg_27, reg_28, reg_29, reg_30, reg_31  

.word reg_zero, reg_at, reg_v0, reg_v1, reg_a0, reg_a1, reg_a2, reg_a3, reg_t0, reg_t1, reg_t2, reg_t3, reg_t4, reg_t5, reg_t6, reg_t7 

.word reg_s0, reg_s1, reg_s2, reg_s3, reg_s4, reg_s5, reg_s6, reg_s7, reg_t8, reg_t9, reg_k0, reg_k1, reg_gp, reg_sp, reg_fp, reg_ra 

 

# Trong đề tài này, nhóm quyết định chọn 5 lệnh với opCode dưới đây 

# Trong 5 lệnh đều đủ 3 khuôn dạng R(lệnh Add, Sub, Sll), I(lệnh Beq), J(lệnh J) 

beq_op: .asciiz "beq" 

add_op: .asciiz "add" 

sll_op:  .asciiz "sll" 

sub_op:  .asciiz "sub" 

j_op: .asciiz "j" 

# Lưu các opCode vào cùng một mảng 

opCodes: .word beq_op, add_op, sll_op, sub_op, j_op 

 

# các biến trung gian 

op: .space 4		# Biến trung gian lưu opCode khi đọc được từ đầu vào 

tmp: .space 40		# Biến trung gian lưu toán hạng thứ 1 khi đọc được từ đầu vào  

tmp2: .space 40		# Biến trung gian lưu toán hạng thứ 2 được từ đầu vào 

tmp3: .space 40		# Biến trung gian toán hạng thứ 3 được từ đầu vào 

 

# Các thông báo của chương trình 

mess: .asciiz "Nhap code mips: " 

cycle: .asciiz "\nSo chu ki cua lenh nay la: " 

 

# Các kết quả, lỗi khi kiểm tra cú pháp 

valid_beq: .asciiz "\nopcode: beq, hop le!" 

valid_add: .asciiz "\nopcode: add, hop le!" 

valid_sll: .asciiz "\nopcode: sll, hop le!" 

valid_sub: .asciiz "\nopcode: sub, hop le!" 

valid_j: .asciiz "\nopcode: j, hop le!" 

valid_operand1: .asciiz "\nToan hang: " 

valid_operand2: .asciiz ", hop le!" 

valid_command: .asciiz "\nCau lenh dung cu phap!" 

 

# Các lỗi 

invalid_op: .asciiz "\nopcode: khong hop le!" 

invalid_operand1: .asciiz "\nToan hang: " 

invalid_operand2: .asciiz ", khong hop le!" 

 

# Biến chứa lệnh nhập vào 

input: .space 100 

 

.text 

main:	li $v0, 4		#In thống báo nhập lệnh để kiểm tra cú pháp 

la $a0, mess 

syscall 

 

li $v0, 8		# Đọc chuỗi nhập vào và lưu vào biến input 

la $a0, input 

li $a1, 100 

syscall 

 

li $t0, 0		# khởi tạo biến chạy để duyệt input 

 

# Duyệt chuỗi input và đọc opCode khi gặp dáu ' ' đầu tiên 

op_loop:lb $t1, input($t0) 

beq $t1, ' ', end_op_loop 

nop 

sb $t1, op($t0) 

addi $t0, $t0, 1 

j op_loop 

end_op_loop: 

jal lowerCase		# Vì opCode nhập vào không quan tâm hoa thường 

nop			# Sử dụng hàm lowerCase sau đó so sánh với các opCod 

 

jal check_opCode	# Kiểm tra opCode vừa đọc được lưu trong biến op 

nop 

 

# Đọc toán hạng đầu tiên và lưu trong biến tmp 

# Bằng cách đọc đến khi gặp dấu ','	 

addi $t0, $t0, 1	# Tiếp tục duyệt input 

li $t9,0		# index cho các mảng tmp, tmp2, tmp3 phục vụ việc lưu vào đúng vị trí  

loop_1: lb $t2, input($t0)	# lưu giá trị phần tử input[$t0] 

sb $t2, tmp($t9) 

 

beq $t2, '\n', end_input1	# kết thúc chuỗi 

nop 

beq $t2, ' ', eat_space1	# đi đến hàm lọai bỏ dấu ' ' 

nop 

 

beq $t2, ',', end_1st_operand  # nếu gặp dấu ',' -> kết thúc toán hạng 1 

nop 

 

addi $t0, $t0, 1 

addi $t9, $t9, 1 

j loop_1 

eat_space1: 

addi $t0, $t0, 1	# tăng index của input, tiếp tục đọc 

j loop_1 

 end_1st_operand: 

 	sb $0, tmp($t9) 

li $t9, 0	      # Đã lưu xong cho tmp, đặt lại biến index để bắt đầu lưu vào tmp2 

 

# Đọc toán hạng thứ 2 và lưu trong biến tmp2	 

# Bằng cách đọc đến khi gặp dấu ',' 

addi $t0, $t0, 1 

loop_2: lb $t2, input($t0) 

sb $t2, tmp2($t9) 

 

beq $t2, '\n',  end_input2 

nop 

beq $t2, ' ', eat_space2	 

nop 

beq $t2, ',', end_2nd_operand 

nop 

addi $t0, $t0, 1 

addi $t9, $t9, 1 

j loop_2 

eat_space2:  

addi $t0, $t0, 1 

j loop_2 

end_2nd_operand:	 

sb $k0, tmp2($t9) 

li $t9, 0		# Đã lưu xong cho tmp2, đặt lại biến index để bắt đầu lưu vào tmp3 

 

# Đọc toán hạng thứ 3 và lưu trong biến tmp3 

# Vì các lệnh chỉ tối đa 3 toán hạng nên toán hạng cuối đọc đến khi kết thúc chuỗi	 

addi $t0, $t0, 1 

 

loop_3: lb $t2, input($t0) 

sb $t2, tmp3($t9) 

 

beq $t2, '\n',   end_3rd_operand 

nop 

 

beq $t2, ' ', eat_space3 

nop 

 

addi $t0, $t0, 1 

addi $t9, $t9, 1 

j loop_3 

eat_space3: 

addi $t0, $t0, 1 

j loop_3 

end_3rd_operand:	 

sb $k0, tmp3($t9) 

li $t9, 0 

addi $t0, $t0, 1 

 

# Dựa vào giá trị trả về của hàm Check_opCode lưu trong $k1 để xác định lệnh -> trả về index mảng opCodes 

# và thực hiện kiểm tra 

switchCase: 

beqz $k1, syntax_beq	# TH: $k1 = 0 -> lệnh beq 

nop			# syntax_beq thực hiện kiểm tra các toán hạng đối với lệnh beq  

 

li $a0, 1		# TH: $k1 = 1 -> lệnh add 

beq $k1, $a0, syntax_add # syntax_ add thực hiện kiểm tra các toán hạng đối với lệnh add 

nop 

 

li $a0, 2		# TH: $k1 = 2 -> lệnh sll 

beq $k1, $a0, syntax_sll# syntax_ sll thực hiện kiểm tra các toán hạng đối với lệnh sll 

nop 

 

li $a0, 3		# TH: $k1 = 3 -> lệnh sub 

beq $k1, $a0, syntax_sub# syntax_ sub thực hiện kiểm tra các toán hạng đối với lệnh sub  

nop 

 

li $a0, 4		# TH: $k1 = 4 -> lệnh j 

beq $k1, $a0, syntax_j  # syntax_ j thực hiện kiểm tra các toán hạng đối với lệnh j 

nop 

 

end_main:	li $v0, 10 

syscall 

#------------------------------------------------------------------------------ 

#------------------------------------------------------------------------------ 

# end_input1, end_input2: các nhãn xử lý khi trong quá trình đọc toán hạng 1, toán hạng 2 

#------------------------------------------------------------------------------ 

end_input1: sb $k0, tmp($t9) 

    j switchCase 

end_input2: sb $k0, tmp2($t9) 

    j switchCase 

    

#------------------------------------------------------------------------------ 

#------------------------------------------------------------------------------ 

# function check_opCode() 

# Kiểm tra opCode có phải là 1 trong 5 lệnh mình kiểm tra hay không 

# Tham số vào: giá trị opCode được lưu trong biến opCode 

# Trả về: 0 -> beq 

#	  1 -> add 

#	  2 -> sll 

#	  3 -> sub 

#	  4 -> j 

#	  và được lưu trong $k1 

#------------------------------------------------------------------------------ 

check_opCode: 

add $v1, $ra, $0		# lưu địa chỉ trả về của hàm tại $v1 

la $t8, op			# lưu địa chỉ biến op vào $t8 

li $t3, 0			# Biến chạy cho mảng 

li $t4, 20			# vì có 5 lệnh và lưu các lệnh theo word -> 4*5 = 20 

 

loop_opCodes: 	beq $t3, $t4, err_op	# Khi duyệt hết mảng mà ko hợp lệ -> báo lỗi 

  	lw $t9, opCodes($t3)	# lấy giá trị từ phần tử opCodes[$t3]  

  	 

jal str_compare		# so sánh op đọc được với từng phần tử trong opCodes 

nop			# 2 tham số là 2 địa chỉ 2 chuỗi lưu ở $t8, $t9 

# kết quả trả về $t5: 0 -> giống nhau, 1 -> khác nhau 

beqz $t5, end_check_opCode	# Nếu op trùng với 1 phần tử trong opCodes -> thỏa mãn 

nop				# trả về $k1 lưu index chính là $t3 

 

addi $t3, $t3, 4	# Tăng lên 4 vì đang làm việc với word 

 

j loop_opCodes		# lặp 

end_check_opCode:	div $k1, $t3, 4	# chia 4 để lấy index của phàn tử và lưu vào $k1 

jr $v1		# trở lại hàm main 

 

#------------------------------------------------------------------------------ 

#------------------------------------------------------------------------------ 

# function check_register() 

# Kiểm tra toán hạng đưa vào có phải là 1 trong 32 thanh ghi hay không 

# So sánh toán hạng lần lượt với các phần tử của mảng registers 

# Đầu vào: toán hạng cần kiểm tra lưu trong $t8 

# Nếu toán hạng không hợp lệ báo lỗi và dừng chương trình 

#------------------------------------------------------------------------------		 

check_register: add $v1, $ra, $0	# lưu đại chỉ trả về của hàm vào $v1 

li $t3, 0		# biến chạy trong mảng registers 

li $t4, 256		# vì có 32 thanh ghi nhưng mỗi thanh ghi để có 2 cách viết 

# và vì lưu trữ word nên: 32*2*4 = 256 -> giá trị biên để kết thúc lặp 

 

loop_registers: beq $t3, $t4, err_operand # dừng lặp khi đã lặp hết phần tử -> không hợp lệ 

  	lw $t9, registers($t3)	  # lưu giá trị phần tử registers[$t3] vào $t9 

  	 

jal str_compare		  # thực hiện so sánh chuỗi trong $t8, $t9 

nop 

 

beqz $t5, end_check_register # khi đã xác định hợp lệ, kết thúc kiểm tra toán hạng 

nop 

 

addi $t3, $t3, 4	# tăng 4 mỗi lần lặp vì lưu word 

 

j loop_registers 

 

end_check_register:	li $v0, 4	# in các thông báo hợp lệ  

la $a0, valid_operand1 

syscall 

 

li $v0, 4 

add $a0, $t8, $0 

syscall 

 

li $v0, 4 

la $a0, valid_operand2 

syscall 

 

jr $v1			# trở lại vói giá trị trả về đã lưu tại $v1 

#------------------------------------------------------------------------------ 

#------------------------------------------------------------------------------ 

# function syntax_beq() 

# Kiểm tra các toán hạng có phù hợp với lệnh beq hay không 

# Đầu vào: các toán hạng lưu ở các biến 

#------------------------------------------------------------------------------ 

syntax_beq: 

li $v0, 4 

la $a0, valid_beq 

syscall 

# check toán hạng thứ 1 là thanh ghi có hợp lệ ko 

la $t8, tmp 

jal check_register 

nop 

# check toán hạng thứ 2 là thanh ghi có hợp lệ ko 

la $t8, tmp2 

jal check_register 

nop 

# check label ở toán hạng thứ 3 

la $t8, tmp3 

jal check_label 

nop 

# In thông báo và chu kì của lệnh 

li $v0, 4 

la $a0, valid_command 

syscall 

 

li $v0, 4 

la $a0, cycle 

syscall 

 

li $v0, 1 

li $a0, 2 

syscall 

 

end_beq: 

j end_main 

 

#------------------------------------------------------------------------------ 

#------------------------------------------------------------------------------ 

# function syntax_add() 

# Kiểm tra các toán hạng có phù hợp với lệnh add hay không 

# Đầu vào: các toán hạng lưu ở các biến, đủ 3 toán  hạng 

#------------------------------------------------------------------------------ 

syntax_add: 

li $v0, 4 

la $a0, valid_add 

syscall 

 

# check toán hạng thứ 1 là thanh ghi có hợp lệ ko 

la $t8, tmp 

jal check_register 

nop 

# check toán hạng thứ 2 là thanh ghi có hợp lệ ko 

la $t8, tmp2 

jal check_register 

nop 

# check toán hạng thứ 3 là thanh ghi có hợp lệ ko 

la $t8, tmp3 

jal check_register 

nop 

# In thông báo và chu kì 

li $v0, 4 

la $a0, valid_command 

syscall 

 

li $v0, 4 

la $a0, cycle 

syscall 

 

li $v0, 1 

li $a0, 1 

syscall 

 

end_add: 

j end_main 

 

#------------------------------------------------------------------------------ 

#------------------------------------------------------------------------------ 

# function syntax_sll() 

# Kiểm tra các toán hạng có phù hợp với lệnh sll hay không 

# Đầu vào: các toán hạng lưu ở các biến, 2 toán hạng đầu là thanh ghi, toán hạng 3 là số 

#------------------------------------------------------------------------------ 

syntax_sll: 

li $v0, 4 

la $a0, valid_sll 

syscall 

end_sll: 

# check toán hạng thứ 1 là thanh ghi có hợp lệ ko 

la $t8, tmp 

jal check_register 

nop 

# check toán hạng thứ 2 là thanh ghi có hợp lệ ko 

la $t8, tmp2 

jal check_register 

nop 

# check toán hạng thứ 3 là hằng sô hay không 

la $t8, tmp3 

jal check_shift 

nop 

# In thông báo và chu kì của lệnh sll 

li $v0, 4 

la $a0, valid_command 

syscall 

 

li $v0, 4 

la $a0, cycle 

syscall 

 

li $v0, 1 

li $a0, 1 

syscall 

 

j end_main 

 

#------------------------------------------------------------------------------ 

#------------------------------------------------------------------------------ 

# function syntax_sub() 

# Kiểm tra các toán hạng có phù hợp với lệnh beq hay không 

# Đầu vào: các toán hạng lưu ở các biến, 3 toán hạng đều là thanh ghi 

#------------------------------------------------------------------------------ 

syntax_sub: 

li $v0, 4 

la $a0, valid_sub 

syscall 

 

# check toán hạng thứ 1 là thanh ghi có hợp lệ ko 

la $t8, tmp 

jal check_register 

nop 

# check toán hạng thứ 2 là thanh ghi có hợp lệ ko 

la $t8, tmp2 

jal check_register 

nop 

# check toán hạng thứ 2 là thanh ghi có hợp lệ ko 

la $t8, tmp3 

jal check_register 

nop 

#In thông báo và chu kì của lệnh sub 

li $v0, 4 

la $a0, valid_command 

syscall 

 

li $v0, 4 

la $a0, cycle 

syscall 

 

li $v0, 1 

li $a0, 1 

syscall 

end_sub: 

j end_main 

 

#------------------------------------------------------------------------------ 

#------------------------------------------------------------------------------ 

# function syntax_j() 

# Kiểm tra các toán hạng có phù hợp với lệnh jum hay không 

# Đầu vào: các toán hạng lưu ở các biến, chỉ cần 1 toán hạng và là label 

#------------------------------------------------------------------------------ 

syntax_j: 

li $v0, 4 

la $a0, valid_j 

syscall 

 

# check toán hạng thứ 1 là nhãn có hợp lệ không 

la $t8, tmp 

jal check_label 

nop 

# Nếu có toán hạng thứ 2 -> báo lỗi	 

lb $t2, tmp2($0) 

bne $t2, $0, err_operand 

nop 

# In thông báo và chu kì của lệnh j 

li $v0, 4 

la $a0, valid_command 

syscall 

 

li $v0, 4 

la $a0, cycle 

syscall 

 

li $v0, 1 

li $a0, 2 

syscall 

end_j:	j end_main 

#------------------------------------------------------------------------------ 

#------------------------------------------------------------------------------ 

# function str_compare() 

# So sánh 2 chuỗi có địa chỉ lưu trong $t8, $t9 

# Trả về: 0 -> trùng nhau 

#	  1 -> khác nhau 

#	  kết quả lưu tại thanh ghi $t5 

#------------------------------------------------------------------------------ 

str_compare:	li $a2, 0			# biến chạy cho cả 2 biến 

 

loop_compare:	add $t6, $t8, $a2		# load địa chỉ của từng kí tự có string trong $t8 

add $t7, $t9, $a2		# load địa chỉ của từng kí tự có string trong $t9 

lb $k0, 0($t6)			# load gía trị 

lb $k1, 0($t7)			# load giá trị 

 

bne $k0, $k1, false		# nếu kí tự khác -> false 

nop				 

beq $k0, $0, true		# nếu là kí tự kết thúc -> trùng nhau 

nop 

addi $a2, $a2, 1 

j loop_compare 

false:	li $t5, 1	# -> gán giá trị trả về 1 -> khác nhau 

jr $ra 

true:	li $t5, 0	# -> gán gía trị trả về 0 -> giống nhau 

jr $ra 

#------------------------------------------------------------------------------ 

#------------------------------------------------------------------------------ 

# function lowerCase() 

# Biến chuỗi đưa vào thành chữ thường 

# mặc định lấy ở op ngay khi đọc được opCode tu input 

#------------------------------------------------------------------------------ 

lowerCase: li $k1, 0	# biến chạy 

loop_tmp_str: 

    lb $t1, op($k1) 

    beq $t1, 0, exit_funct # nếu là kí tự kết thúc chuỗi thì thóat hàm 

    blt $t1, 'A', case	    

    bgt $t1, 'Z', case 

    addi $t1, $t1, 32	  # nếu là in hoa thì giảm 32 mã ascii -> chũ thường 

    sb $t1, op($k1) 

 

case:  

    addi $k1, $k1, 1 

    j loop_tmp_str 

exit_funct: jr $ra 

#------------------------------------------------------------------------------ 

#------------------------------------------------------------------------------ 

# function check_shift() 

# kiểm tra chuỗi trong $t8 có phải là hằng sô hay không và in lỗi 

# kiểm tra kí tự có phải là số hay không, phục vụ cho toán hạng thứ 3 của lệnh sll 

#------------------------------------------------------------------------------ 

 

check_shift: li $k1, 0		# biến chạy 

     la $t8, tmp3 

loop_shift: 

    lb $t1, tmp3($k1) 

    beq $t1, 0, end_check_shift 

    blt $t1, '0', invalid 

    bgt $t1, '9', invalid 

    addi $k1, $k1, 1 

    j loop_shift 

invalid:  

    j err_operand 

end_check_shift: 

li $v0, 4 

la $a0, valid_operand1 

syscall 

 

li $v0, 4 

add $a0, $t8, $0 

syscall 

 

li $v0, 4 

la $a0, valid_operand2 

syscall 

 

jr $ra 

#------------------------------------------------------------------------------ 

#------------------------------------------------------------------------------ 

# function check_label() 

# Kiểm tra xem toán hạng gán vào $t8 cso thảo mãn là nhãn không 

# Nhãn bao gồm kí tự chữ cái, sô và dấu gạch dưới 

#------------------------------------------------------------------------------	 

check_label: li $k1, 0 

 

loop_label: add $k0, $t8, $k1 

    lb $t1, 0($k0) 

    beq $t1, 0, end_check_label 

    nop 

    blt $t1, '0', invalid_label 

    nop 

    bgt $t1, '9', check_up_letter 

    nop 

loop:   addi $k1, $k1, 1 

    	j loop_label 

check_up_letter: 

blt $t1, 'A', invalid_label 

    	nop 

    	bgt $t1, 'Z', check_specialChar 

    	nop 

    	j loop 

check_specialChar: 

bne $t1, '_', check_low_letter 

nop 

j loop 

check_low_letter: 

blt $t1, 'a', invalid_label 

nop 

    	bgt $t1, 'z', invalid_label 

    	nop 

    	j loop 

invalid_label: 

j err_operand 

end_check_label: 

li $v0, 4 

la $a0, valid_operand1 

syscall 

 

li $v0, 4 

add $a0, $t8, $0 

syscall 

 

li $v0, 4 

la $a0, valid_operand2 

syscall 

 

jr $ra 

#------------------------------------------------------------------------------ 

#------------------------------------------------------------------------------ 

# err_op, err_operand 

# In các lỗi liên quan đến opCode và toán hạng 

# Sau đó trở về hàm main để kết thúc chương trình 

# riêng hàm err_operand có in ra tên toán hạng thông qua $t8 

#------------------------------------------------------------------------------	 

err_op:  

li $v0, 4 

la $a0, invalid_op 

syscall 

j end_main 

err_operand: 

li $v0, 4 

la $a0, invalid_operand1 

syscall 

 

li $v0, 4 

add $a0, $t8, $0 

syscall 

 

li $v0, 4 

la $a0, invalid_operand2 

syscall 

j end_main 