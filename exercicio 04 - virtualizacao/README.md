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

	$ 	scp  informatica@10.40.1.165:/home/informatica/linuxmint*.iso .   



#### Criar uma VM 


- Novo

- Menu Configurações
	- Menu armazenamento
		- Controladora IDE  
			-- Acrescentar Disco Óptico (local e selecionar a ISO)	  
			-- marcar no link da ISO e selecionar Live CD/DVD  

- Start linux Mint   


