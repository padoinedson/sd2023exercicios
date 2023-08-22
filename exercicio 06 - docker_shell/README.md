


## Atividade 1 ---- docker com shell


#### criar um arquivo

 $ nano a.sh

		> #!/bin/sh
		> echo "hello, a hora é $(date)."

 $ chmod +x a.sh 
 $ ./a.sh 





#### criar uma imagem  



  $ nano Dockerfile

> 			FROM alpine
> 			COPY a.sh /
> 			CMD ["/a.sh"]
 
 
 
