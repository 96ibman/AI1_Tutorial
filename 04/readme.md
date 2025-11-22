# Fourth Tutorial Session
Date: 24 Nov 2025

## Sheet and Solution
- You can find the provided assignment sheet in `sheet04.pdf`
- You can find the provided master solution in `solution04.pdf`

## Minimax and Alpha-Beta
["MinMax_AlphaBeta.ipynb"](./MinMax_AlphaBeta.ipynb) is an implementation of minimax and alpha-beta pruning to solve the game tree presented in the sheet (and some follow-up questions)

## Alpha-Beta Pruning Visualized
- [Here](https://www.canva.com/design/DAG5Po-qgig/fgzWegktDgWmIcd9tMwg-Q/edit?utm_content=DAG5Po-qgig&utm_campaign=designshare&utm_medium=link2&utm_source=sharebutton) you can find a visualization of how Alpha-Beta Pruning work (simplified, how I like to trace the algorithm)
- [Here](https://www.canva.com/design/DAG5QVq9hiY/hCC7xvH-V1A5xcpo5G4AMQ/edit?utm_content=DAG5QVq9hiY&utm_campaign=designshare&utm_medium=link2&utm_source=sharebutton) you can find a different visualization of how actually alpha-beta pruning works (showing the value of alpha and beta for each node, prune when alpha is greater than or equal to beta)

## TicTacToe
- ["tictactoe/TicTacToe_MinMax.pdf"](./tictactoe/TicTacToe_MinMax.pdf) is a simple trace of minimax search for tic-tac-toe game.
- ["tictactoe/tictactoe.py"](./tictactoe/tictactoe.py) is a python script to play tic-tac-toe against an agent that uses Alpha-Beta Pruning.
    - download it and run it with `python PATH_TO_PY_FILE` (try to beat it :D) 

## Nim Game
- ["nim/nim_MinMax.pdf"](./nim/nim_MinMax.pdf) is a simple trace of minimax search for the nim game described in the sheet
- ["nim/nimgame.py"](./nim/nimgame.py) is a python script to play nim (but using the trick to win not using minimax)

