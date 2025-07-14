WIDTH, HEIGHT = ((400, 600))
screen = pygame.display.set_mode((WIDTH, HEIGHT))
pygame.display.set_caption("Volleyball Reaction Game")
BLUE = (0, 100, 255)  
GREEN = (0, 255, 0) 
BLACK = (0, 0, 0)
pygame.draw.circle(screen, BLUE, (ball_x, int(ball_y)), 15)
ball_y = -20  # Starts above the screen
ball_speed = 5