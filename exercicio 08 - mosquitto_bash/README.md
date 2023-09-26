
# Copiar fontes:

$ cp /home/pp2022/sensor.sh .  
$ cp /home/pp2022/semaforo.sh .  


##	Test 2 - localhost com bash


-	Terminal 1:  

		$ mosquitto_sub -v -t '#'  


-	Terminal 2:  

		$ cd bash  

		$ bash sensor.sh start  

	



####	Test 2.1 - localhost com bash

- 	Terminal 1:  

		$ mosquitto_sub -v -t '#'  


- 	Terminal 2:  

		$ cd bash    

		$ bash semaforo.sh sede    



- 	Terminal 3:  

		$ cd bash  

		$ bash semaforo.sh posto  


