import turtle
import time

screen = turtle.Screen()
screen.title("Volleyball Reaction Game")
screen.bgcolor("white")
screen.setup(width=400, height=600)
screen.tracer(0)

# Ball setup
ball = turtle.Turtle()
ball.shape("circle")
ball.color("blue")
ball.penup()
ball.goto(0, 250)

# Zone setup
zone = turtle.Turtle()
zone.shape("square")
zone.shapesize(stretch_wid=1, stretch_len=5)
zone.color("green")
zone.penup()
zone.goto(0, -220)

# Score display
score_display = turtle.Turtle()
score_display.hideturtle()
score_display.penup()
score_display.goto(-180, 260)
score_display.color("black")
score_display.write("Score: 0  Lives: 3", font=("Arial", 14, "bold"))

# Start Game Button setup
game_started = False
start_button = turtle.Turtle()
start_button.shape("square")
start_button.shapesize(stretch_wid=2, stretch_len=10)
start_button.color("lightblue")
start_button.penup()
start_button.goto(0, 0)

label = turtle.Turtle()
label.hideturtle()
label.penup()
label.goto(0, -10)
label.write("Start Game", align="center", font=("Arial", 16, "bold"))

# Game variables
score = 0
lives = 3
ball_y = 250
ball_speed = 1.5
ball_direction = "down"
zone_speed = 6
zone_direction = 1

def update_scoreboard():
    score_display.clear()
    score_display.write(f"Score: {score}  Lives: {lives}", font=("Arial", 14, "bold"))

def hit():
    global ball_y, score, ball_direction
    screen.onkey(None, "space")
    if -250 < ball.ycor() < -200 and abs(ball.xcor() - zone.xcor()) < 50:
        score += 1
        ball_y = 250
        ball.goto(0, ball_y)
        ball_direction = "down"
        update_scoreboard()
    screen.onkey(hit, "space")

def game_over():
    score_display.goto(-80, 0)
    score_display.write("Game Over!", font=("Arial", 20, "bold"))
    turtle.bye()

def start_game(x, y):
    global game_started
    if -100 < x < 100 and -20 < y < 20:
        start_button.hideturtle()
        label.clear()
        game_started = True

screen.listen()
screen.onkey(hit, "space")
screen.onclick(start_game)

# Game loop
while True:
    if not game_started:
        screen.update()
        time.sleep(0.01)
        continue

    if ball_direction == "down":
        ball_y -= ball_speed
    else:
        ball_y += ball_speed

    ball.goto(0, ball_y)
    zone.setx(zone.xcor() + zone_speed * zone_direction)

    if zone.xcor() > 150 or zone.xcor() < -150:
        zone_direction *= -1

    if ball_y < -300 and ball_direction == "down":
        ball_direction = "up"

    if ball_y > 250 and ball_direction == "up":
        lives -= 1
        update_scoreboard()
        if lives == 0:
            game_over()
            break
        ball_direction = "down"
        ball_y = 250
        ball.goto(0, ball_y)

    screen.update()
    time.sleep(0.04)

score_display.write("Good job! You did great ", align="center", font=("Arial", 14, "italic"))














    


