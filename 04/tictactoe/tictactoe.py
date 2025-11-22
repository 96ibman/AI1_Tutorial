import math

# Board positions:
# 1 2 3
# 4 5 6
# 7 8 9

def print_board(board):
    def cell(i):
        return board[i] if board[i] is not None else "-"
    print()
    print(cell(0), cell(1), cell(2))
    print(cell(3), cell(4), cell(5))
    print(cell(6), cell(7), cell(8))
    print()

def winner(board):
    wins = [
        (0,1,2), (3,4,5), (6,7,8),
        (0,3,6), (1,4,7), (2,5,8),
        (0,4,8), (2,4,6)
    ]
    for (a,b,c) in wins:
        if board[a] is not None and board[a] == board[b] == board[c]:
            return board[a]
    return None

def full(board):
    return all(x is not None for x in board)

def game_over(board):
    return winner(board) is not None or full(board)

def utility(board, comp, human):
    w = winner(board)
    if w == comp:
        return 1
    if w == human:
        return -1
    return 0

def successors(board, player):
    moves = []
    for i in range(9):
        if board[i] is None:
            new_board = board[:]
            new_board[i] = player
            moves.append((i, new_board))
    return moves

def alphabeta(board, player, comp, human, alpha, beta):
    if game_over(board):
        return utility(board, comp, human)

    if player == comp:
        best = -math.inf
        for (_, child) in successors(board, comp):
            val = alphabeta(child, human, comp, human, alpha, beta)
            best = max(best, val)
            alpha = max(alpha, best)
            if alpha >= beta:
                break
        return best

    else:
        best = math.inf
        for (_, child) in successors(board, human):
            val = alphabeta(child, comp, comp, human, alpha, beta)
            best = min(best, val)
            beta = min(beta, best)
            if alpha >= beta:
                break
        return best

def best_move(board, comp, human):
    best_val = -math.inf
    best_action = None
    for (move, child) in successors(board, comp):
        val = alphabeta(child, human, comp, human, -math.inf, math.inf)
        if val > best_val:
            best_val = val
            best_action = move
    return best_action

def human_move(board):
    while True:
        raw = input("Your move (1 to 9): ").strip()

        if not raw.isdigit():
            print("Invalid input. Enter a number 1 to 9.")
            continue

        pos = int(raw) - 1

        if pos < 0 or pos > 8:
            print("Invalid position. Choose 1 to 9.")
            continue

        if board[pos] is not None:
            print("Cell already taken. Try again.")
            continue

        return pos

def choose_who_plays_x():
    while True:
        raw = input("Enter 1 or 2: ").strip()
        if raw == "1":
            return "human"
        if raw == "2":
            return "computer"
        print("Invalid choice. Enter 1 or 2.")

def yes_no(prompt):
    while True:
        raw = input(prompt).strip().lower()
        if raw in ["y", "yes"]:
            return True
        if raw in ["n", "no"]:
            return False
        print("Enter y or n.")

def play_once():
    print("Use positions 1 to 9 to play:")
    print(" 1 | 2 | 3")
    print("-----------")
    print(" 4 | 5 | 6")
    print("-----------")
    print(" 7 | 8 | 9")
    print()

    board = [None] * 9

    print("Who plays X (goes first)?")
    print("1. You")
    print("2. Computer")
    starter = choose_who_plays_x()

    if starter == "human":
        human = "X"
        comp = "O"
    else:
        comp = "X"
        human = "O"

    current = "X"

    print_board(board)

    while not game_over(board):
        if current == human:
            print("Your turn.")
            move = human_move(board)
            board[move] = human
        else:
            print("Computer's turn...")
            move = best_move(board, comp, human)
            board[move] = comp

        print_board(board)
        current = "O" if current == "X" else "X"

    w = winner(board)
    if w == human:
        print("You win.")
    elif w == comp:
        print("Computer wins.")
    else:
        print("Draw.")

def main():
    while True:
        play_once()
        if not yes_no("Play again? (y/n): "):
            break

if __name__ == "__main__":
    main()