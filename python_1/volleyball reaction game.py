import turtle
import time

time.sleep(1)

screen = turtle.Screen()
screen.title("Volleyball Reaction Game")
screen.bgcolor("white")
screen.setup(width=400, height=600)
screen.tracer(0)

ball = turtle.Turtle()
ball.shape("circle")
ball.color("blue")
ball.penup()
ball.goto(0, 250)

zone = turtle.Turtle()
zone.shape("square")
zone.shapesize(stretch_wid=1, stretch_len=5)
zone.color("green")
zone.penup()
zone.goto(0, -220)
zone_direction = 1

score_display = turtle.Turtle()
score_display.hideturtle()
score_display.penup()
score_display.goto(-180, 260)
score_display.color("black")

ball_y = 250
ball_speed = 2
zone_speed = 8
score = 0
lives = 3

def update_score():
    score_display.clear()
    score_display.write(f"Score: {score}  Lives: {lives}", font=("Arial", 14, "normal"))

update_score()

def hit():
    global ball_y, score, ball_speed
    ball_x = ball.xcor()
    zone_x = zone.xcor()
    if -250 < ball.ycor() < -200 and abs(ball_x - zone_x) < 50:
        ball_y = 250
        ball.goto(0, ball_y)
        score += 1
        ball_speed = min(ball_speed + 0.5, 10)
        update_score()

screen.listen()
screen.onkey(hit, "space")

while True:
    ball_y -= ball_speed
    ball.goto(0, ball_y)

    zone.setx(zone.xcor() + zone_speed * zone_direction)
    if zone.xcor() > 150 or zone.xcor() < -150:
        zone_direction *= -1

    if ball_y < -300:
        lives -= 1
        update_score()
        if lives == 0:
            break
        ball_y = 250
        ball.goto(0, ball_y)
        time.sleep(0.5)

    screen.update()
    time.sleep(0.04)

turtle.done()










    


