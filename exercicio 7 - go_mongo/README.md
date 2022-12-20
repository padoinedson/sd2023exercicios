
$ mkdir exercicio7

$ cd exercicio7

$ go mod init mongo-with-golang
 
$ go get go.mongodb.org/mongo-driver/mongo
$ go get go.mongodb.org/mongo-driver/bson



## abrir um terminal para o DB

### entrar no DB
$ mongodb

vamos usar:  
- Database -> "testing"  
- Collection -> "users"  


> use testing  
> db.users.find().pretty();  

