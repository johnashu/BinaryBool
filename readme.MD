# Binary Bools

A Solidity based look at using bitmasking to use 32 byte words as efficient arrays.

`./py`

Notes and methods in Python for quick and dirty play.

`./src/BinaryBools.sol`

A verbose scratchpace looking at masking without using shifts.  This is the most efficient on gas if masks can be predetermined and hardcoded.

`./src/lottery.sol`

An example of using 32 byte words to create lottery tickets and determine the outcome.

`./src/AddRemoveFlags`

Example of using a 32 byte word as an array of boolean flags. - * Will be used in the future 'GridMap' *

`./src/ManyRandomNumbersFromOne`

Given a number of plays passed, we take 1 full 32 byte random word and use bitshifting to make our number smaller and analyse the result.  
Winning plays are added to a total and the amount is returned.

