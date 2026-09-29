import random
import time

def get_computer_move(pile_size):
    remainder = pile_size % 4
    if remainder == 0:
        return random.randint(1, min(3, pile_size))
    return remainder

def play_game():
    print("--- THE GAME OF MATCHES ---")
    print("Rules: Take 1, 2, or 3 matches. Whoever takes the last match WINS.")
    print("-" * 40)

    pile_size = random.randint(10, 20)
    print(f"\nGenerated a pile of {pile_size} matches.")

    while True:
        choice = input("Who should start? (1 for You, 2 for Computer): ").strip()
        if choice in ['1', '2']:
            is_player_turn = (choice == '1')
            break
        print("Invalid choice. Please enter 1 or 2.")

    while pile_size > 0:
        print(f"\nMatches remaining: {pile_size} : {'|' * pile_size}")
        
        if is_player_turn:
            while True:
                try:
                    move = int(input("How many matches do you take (1, 2, or 3)? "))
                    if move in [1, 2, 3] and move <= pile_size:
                        pile_size -= move
                        print(f"You took {move} matches.")
                        break
                    else:
                        print(f"Invalid move. You can take 1-3 matches, but not more than are left.")
                except ValueError:
                    print("Please enter a number.")
        else:
            print("Computer is thinking...", end="", flush=True)
            time.sleep(1) # Artificial delay for realism
            move = get_computer_move(pile_size)
            pile_size -= move
            print(f"\rComputer took {move} matches.   ")

        if pile_size == 0:
            if is_player_turn:
                print("\n" + "="*30)
                print("🎉 YOU TOOK THE LAST MATCH! YOU WIN! 🎉")
                print("="*30)
            else:
                print("\n" + "="*30)
                print("🤖 COMPUTER TOOK THE LAST MATCH. YOU LOSE. 🤖")
                print("="*30)
            break

        is_player_turn = not is_player_turn

if __name__ == "__main__":
    while True:
        play_game()
        again = input("\nPlay again? (y/n): ").lower().strip()
        if again != 'y':
            print("Thanks for playing!")
            break