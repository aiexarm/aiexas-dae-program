import random

def intro():
    print("Hello!")
    print("Let's play a guessing game.")
    print("Ok")
    print("Think of an object, and I'll try to guess it based on your descriptions.")
    print("Ready? Here we go!")
    print()

def game():
    # List of objects with their descriptions
    objects = {
        "cactus": "I am green and spiky.",
        "apple": "I am red or green, and you can eat me.",
        "carrot": "I am orange and I grow underground.",
        "sunflower": "I am tall, yellow, and grow in gardens.",
        "banana": "I am yellow and curved, and you peel me.",
    }
    
    # List of the keys (object names) in the game
    object_names = list(objects.keys())

    # Randomly choose an object from the list
    object_to_guess = random.choice(object_names)
    description = objects[object_to_guess]

    print(f"Alright, I’m thinking of something. Here's a hint:")
    print(f"Description: {description}")
    
    # Game loop to interact with the player
    guesses_left = 3  # Number of attempts for the program to guess

    while guesses_left > 0:
        # Program guesses
        print("\nWhat do you think it is?")
        guess = input("Type your guess: ").lower().strip()

        # Check if the player's guess is correct
        if guess == object_to_guess:
            print(f"Yay! You guessed it correctly! It was a {object_to_guess}.")
            break
        else:
            guesses_left -= 1
            if guesses_left > 0:
                print(f"Oops, that's not it. You have {guesses_left} attempts left.")
            else:
                print("Sorry, I couldn't guess it. Better luck next time!")
                print(f"The correct answer was: {object_to_guess}")

def main():
    intro()  # Greet the player and explain the game
    game()  # Run the game loop

if __name__ == "__main__":
    main()

WIDTH, HEIGHT = 400, 600
screen = pygame.display.set_mode((WIDTH, HEIGHT))
pygame.display.set_caption("Volleyball Reaction Game")
