package main

import (
	"context"
	"fmt"

	"go.mongodb.org/mongo-driver/bson"
	"go.mongodb.org/mongo-driver/mongo"
	"go.mongodb.org/mongo-driver/mongo/options"
	"go.mongodb.org/mongo-driver/mongo/readpref"
)

func main() {
	client, err := mongo.Connect(context.TODO(), options.Client().ApplyURI("mongodb://localhost:27017"))
	if err != nil {
		panic(err)
	}
	if err := client.Ping(context.TODO(), readpref.Primary()); err != nil {
		panic(err)
	}

	usersCollection := client.Database("testing").Collection("users")




	// insert a single document into a collection
	user := bson.D{{"fullName", "Anna"}, {"age", 30}}
	
	result, err := usersCollection.InsertOne(context.TODO(), user)
	if err != nil {
		panic(err)
	}
	
	fmt.Println(result.InsertedID)




	// insert multiple documents into a collection
	users := []interface{}{
		bson.D{{"fullName", "Carlos"}, {"age", 25}},
		bson.D{{"fullName", "Dante"}, {"age", 20}},
		bson.D{{"fullName", "Edson"}, {"age", 28}},
	}
	
	results, err := usersCollection.InsertMany(context.TODO(), users)
	
	if err != nil {
		panic(err)
	}
	
	fmt.Println(results.InsertedIDs)

}
