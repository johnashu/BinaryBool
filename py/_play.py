for i in range(256):
    print(hex(i))

print('1' + '0' * 64)

rand =   89416941894186914891919618918918961891896968916157498416341894616
maxDiv = 10000000000000000000000000000000000000000000000000000000000000000
won = 0
for i in range(64):
    toCheck = rand // maxDiv
    maxDiv //= 10
    if toCheck % 2 == 0:
        won += 1
    print(toCheck)
    print(maxDiv)

print(won)