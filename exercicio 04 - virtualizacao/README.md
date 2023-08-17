# Sistemas Distribuídos

## Exercício Virtualização 



### Descrição da atividade:


#### Instalar Virtualbox

	Abrir Ubuntu Software

	Instalar Virtualbox


#### Instalar ssh 


	$ 	sudo apt install ssh




#### Copiar arquivo ISO do servidor

>      scp nome_do_arquivo user@ip_do_servidor:/caminho_do_servidor  
>      scp user@ip_do_servidor:/caminho_do_servidor/nome_do_arquivo local  

	$ 	scp  informatica@200.132.196.97:/home/informatica/linuxmint*.iso .   

> 		conformar difitando "yes"



#### Criar uma VM 

- Abrir Virtualbox  

- Novo
	- Definir mem, disco, ...

- Menu Configurações
	- Menu armazenamento
		- Controladora IDE  
			-- Acrescentar Disco Óptico (selecionar local e selecionar a ISO)	  
			-- Clicar no link da ISO e selecionar Live CD/DVD  

- Start linux Mint   


