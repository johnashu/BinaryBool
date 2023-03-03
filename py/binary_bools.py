state = 0b00000000

allOff = 0b00000000
allOn = 0b11111111

red = 0b10000000
green = 0b01000000
blue = 0b00100000
orange = 0b00010000
black = 0b00001000
white = 0b00000100
purple = 0b00000010
pink = 0b00000001

colours = (red, green, blue, orange, black, white, purple, pink)


def markTrueAtPosistion(pos):
    return state | pos


def markFalseAtPosistion(pos):
    return state ^ pos


def resetAll():
    return allOff


for colour in colours:
    state = markTrueAtPosistion(colour)
    print(bin(state))

for colour in colours:
    state = markFalseAtPosistion(colour)
    print(bin(state))
