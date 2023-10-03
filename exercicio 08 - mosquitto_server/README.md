
##	Test - servidor mosquitto.org
 


> Disponível em: https://test.mosquitto.org/  

 
		Terminal 1:  

		$ mosquitto_sub -h test.mosquitto.org -t "casa/sensor1"  


		Terminal 2:  

		$ mosquitto_pub -h test.mosquitto.org -m "22.0" -t "casa/sensor1"  

		$ mosquitto_pub -h test.mosquitto.org -m "22.0" -t "casa/sensor2"  




####	Test 3.1 - servidor mosquitto.org - chamada

		Terminal 1:  

		$ mosquitto_sub -h test.mosquitto.org -t "chamada/2405"  


		Terminal 2:  

		$ mosquitto_pub -h test.mosquitto.org -m "padoin" -t "chamada/2405"  



