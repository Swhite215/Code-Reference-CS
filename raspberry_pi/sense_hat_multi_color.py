from sense_hat import SenseHat

sense = SenseHat()

blue = (0, 0, 255)
yellow = (255, 255, 0)

while True:
  sense.show_message("Raspberry Pi is awesome!", text_colour=yellow, back_colour=blue)
