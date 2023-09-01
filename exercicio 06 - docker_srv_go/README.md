



## Atividade 1 ---- docker com servidor go



#### criar uma imagem  


	$ nano Dockerfile

>		FROM golang:1.17  
>		WORKDIR /go/src  
>		COPY main.go .  
>		RUN go build -o server main.go  
>		CMD ["./server"]  

 
 

	$ nano main.go


>				package main  

>				import (  
>				    "log"  
>				    "net/http"  
>				)  

>				func main() {  
>				    http.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {  
>				        w.Write([]byte("<h1>Welcome</h1>"))  
>				    })  
>				    log.Fatal(http.ListenAndServe(":8080", nil))  
>				}  



	$ sudo docker build -t gopadoin . 


	$ docker run --rm --name nginx -p 8080:80  gopadoin


> 			para testar - browser localhost:8080  
> 									- em outro terminal $ lynx localhost:8080



