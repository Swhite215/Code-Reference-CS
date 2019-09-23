from sense_hat import SenseHat
from time import sleep

sense = SenseHat()

# Define some colours
p = (128, 0, 128) # Purple
b = (0, 0, 0) # Black

# Set up where each colour will display
letter_pixels = [
    p, p, p, b, b, p, p, p,
    p, p, b, p, p, b, p, p,
    p, p, b, p, p, p, p, p,
    p, p, p, b, b, p, p, p,
    p, p, p, p, p, b, p, p,
    p, p, b, p, p, b, p, p,
    p, p, p, b, b, p, p, p,
    p, p, p, p, p, p, p, p
]

sense.set_rotation(90)

# Display these colours on the LED matrix
sense.set_pixels(letter_pixels)

while True:
  sleep(2)
  sense.flip_h()
