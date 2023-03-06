from base import (
    base,
    add_flag_to_position,
    remove_flag_to_position,
    bytes_to_array,
    bytes_to_arrays,
    _exists,
)

state = base
grid = [state, state, state, state, state, state, state, state, state, state]

def display_grid(grid: list):
    for x in grid:
        print(hex(x))


def add_to_grid(grid: list, pos: int, row: int):
    grid[row] = add_flag_to_position(grid[row], pos)
    return grid


def remove_from_grid(grid: list, pos: int, row: int):
    grid[row] = remove_flag_to_position(grid[row], pos)
    return grid


def add_to_zone(grid: list, row: int, zone: int, pos: int):
    # zone 0 = 1-10
    # zone 1 = 11-20
    # zone 2 = 21-30
    # zone 3 = 31-40
    # zone 4 = 41-50
    # zone 5 = 51-60

    ratio = 10  # (per zone)
    if pos > 10:
        return False
    bit_pos = pos + (zone * ratio)
    print (bit_pos)
    grid[row] = add_flag_to_position(grid[row], bit_pos)
    return grid


def add_to_all_zones(grid: list, row: int, pos: int):
    # zone 0 = 1-10
    # zone 1 = 11-20
    # zone 2 = 21-30
    # zone 3 = 31-40
    # zone 4 = 41-50
    # zone 5 = 51-60

    zones = [0, 10, 20, 30, 40, 50]
    ratio = 10  # (per zone)

    if pos > 10:
        return False
    state = grid[row]
    bit_pos = pos * 4

    for z in zones:
        shifted = base >> (z + pos) * 4
        state = state ^ shifted

    grid[row] = state
    return grid


def matrixify_bytes_grid(grid: list) -> list:
    new_grid = []
    for y in grid:
        new_grid.append(bytes_to_array(y))
    return new_grid


def matrixify_bytes_grid_zones(grid: list) -> list:
    new_grid = []
    for y in grid:
        new_grid.append(bytes_to_arrays(y, 10))
    return new_grid


# for i in range(10):
#     grid = add_to_grid(grid, i + 1, i)
#     grid = add_to_grid(grid, i * 2, i)


# display_grid(grid)

# matrix_arr = matrixify_bytes_grid(grid)
# for i, a in enumerate(matrix_arr):
#     print(i, a)

grid = add_to_zone(grid, 0, 2, 4)
grid = add_to_zone(grid, 0, 0, 2)

for i in range(10):
    
    grid = add_to_all_zones(grid, i, 1)
    grid = add_to_all_zones(grid, i, 3)
    grid = add_to_all_zones(grid, i, 5)

display_grid(grid)

matrix_arr = matrixify_bytes_grid_zones(grid)
for i, a in enumerate(matrix_arr):
    print(i, a)

for i in range(10):
    grid = remove_from_grid(grid, i + 4, i)

grid = add_to_grid(grid, 3, 2)

display_grid(grid)


for i in range(257):
    print(hex(i))