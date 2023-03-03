from base import base, add_flag_to_position,  check_num_flags

status = base
winningNumbers = [1, 4, 6, 33, 44, 63]
for i in winningNumbers:
    status = add_flag_to_position(status, i) 
    # status = add_flag_to_position(status, i) # 2 x to check that it does the _exists check..

print(hex(status))
check = 0xff00f0f00000000000000000000000000f0000000000f000000000000000000f
c = check_num_flags(check, 6, status)
print(c)