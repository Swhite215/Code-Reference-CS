from sense_hat import SenseHat

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

# Display these colours on the LED matrix
sense.set_pixels(letter_pixels)
