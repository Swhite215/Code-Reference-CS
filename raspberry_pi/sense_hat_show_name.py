from sense_hat import SenseHat
from time import sleep

sense = SenseHat()

name = "Spencer"

for letter in name:
    sense.show_letter(letter)
    sleep(1)
    
sense.clear()
