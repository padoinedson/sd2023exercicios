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

	

	// retrieve single and multiple documents with a specified filter using FindOne() and Find()
	// create a search filer
	filter := bson.D{
		{"$and",
			bson.A{
				bson.D{
					{"age", bson.D{{"$gt", 25}}},
				},
			},
		},
	}

	// retrieve all the documents that match the filter
	cursor, err := usersCollection.Find(context.TODO(), filter)
	
	if err != nil {
		panic(err)
	}

	// convert the cursor result to bson
	var results []bson.M
	
	if err = cursor.All(context.TODO(), &results); err != nil {
		panic(err)
	}

	// display the documents retrieved
	fmt.Println("displaying all results from the search query")
	for _, result := range results {
		fmt.Println(result)
	}

	// retrieving the first document that matches the filter
	var result bson.M
	
	if err = usersCollection.FindOne(context.TODO(), filter).Decode(&result); err != nil {
		panic(err)
	}

	// display the document retrieved
	fmt.Println("displaying the first result from the search filter")
	fmt.Println(result)

}
