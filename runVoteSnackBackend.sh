#!/bin/sh
sudo hamachi login
docker start 26ed60c0b652
java -jar -Dspring.profiles.active=dev,web,service /home/vince/server/vote-snack-backend-0.0.1-SNAPSHOT.jar
