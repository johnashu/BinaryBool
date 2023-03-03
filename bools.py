base = 0xF000000000000000000000000000000000000000000000000000000000000000
full = 0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF


def _exists(state: int, pos: int) -> bool:
    bit_pos = pos * 4
    shifted = base >> bit_pos
    anded = state & shifted
    return anded == shifted


def add_flag_to_position(state: int, pos: int) -> int:
    if _exists(state, pos):
        return state
    bit_pos = pos * 4
    shifted = base >> bit_pos
    return state ^ shifted


def remove_flag_to_position(state: int, pos: int) -> int:
    if not _exists(state, pos):
        return state
    bit_pos = 4 * pos
    shifted = base >> bit_pos
    
    return state ^ shifted




status = base

status1 = add_flag_to_position(status, 63)
print(hex(status1))

status2 = add_flag_to_position(status1, 6)
print(hex(status2))

status3 = add_flag_to_position(status2, 11)
print(hex(status3))

status = base
for i in range(1, 64):
    pre = _exists(status, i)
    status = add_flag_to_position(status, i)
    print(pre, i, hex(status))
    status = add_flag_to_position(status, i)
    post = _exists(status, i)
    print(pre, i, hex(status), post)

status = full
for i in range(1, 64):
    pre = _exists(status, i)
    status = remove_flag_to_position(status, i)
    print(pre, i, hex(status))
    status = remove_flag_to_position(status, i)
    post = _exists(status, i)
    print(pre, i, hex(status), post)

# e = _exists(0xF000F00000000000000000000000000000000000000000000000000000000000,4)

# print(e)

status = base
winningNumbers = [1, 4, 6, 33, 44, 63]
for i in winningNumbers:
    status = add_flag_to_position(status, i)

print(hex(status))


check = 0xf000f0f0000000000ff0000000000000000000000000f000000000000000000f
count = 0
# skip 0 as that is our init bit
for i in range(1,64):
    if _exists(check, i):
        count += 1

print(count)

