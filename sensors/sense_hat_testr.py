from sense_hat import SenseHat
from time import sleep

sense = SenseHat()
sense.set_imu_config(True, True, True)
sense.rotation = 270

while True:
    try:
        temp = sense.get_temperature_from_humidity()
        humidity = sense.get_humidity()
        print("Humidity: %s %%rH" % humidity)
     #   orientation = sense.get_orientation_degrees()
     #   print("p: {pitch}, r: {roll}, y: {yaw}".format(**orientation))     
       # print(sense.accelerometer_raw)
       # print(sense.gyroscope_raw)
       # print(sense.compass_raw)        
        sense.show_message(str(round(temp, 2)), text_colour=[0, 255, 224])
       # sleep()
    except KeyboardInterrupt:
        sense.clear()
        break