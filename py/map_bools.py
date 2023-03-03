from base import base, add_flag_to_position, remove_flag_to_position, check_num_flags, bytes_to_array

state = base
grid = [
    state,
    state,
    state,
    state,
    state,
    state,
    state,
    state,
    state,
    state,
    state,
    state,
    state,
    state,
    state,
    state,
    state,
    state,
    state,
    state,
]

def display_grid(grid: list):
    for x in grid:
        print(hex(x))

def add_to_grid(pos:int, row: int):
    grid[row] = add_flag_to_position(grid[row], pos)
    return grid

def remove_from_grid(pos, row: int):
    grid[row] = remove_flag_to_position(grid[row], pos)
    return grid

def matrixify_bytes_grid(grid:list) -> list:
    new_grid = []
    for y in grid:
        new_grid.append(bytes_to_array(y))
    return new_grid


for i in range(20):
    grid = add_to_grid(i+1, i)
    grid = add_to_grid(i*2, i)
    grid = add_to_grid(i*3, i)
    grid = add_to_grid(i*4, i)

display_grid(grid)

for i in range(20):
    grid = remove_from_grid(i+4, i)
grid = add_to_grid(3, 2)

display_grid(grid)

matrix_arr = matrixify_bytes_grid(grid)
for i, a in enumerate(matrix_arr):
    print(i, a)

