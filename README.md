# Smart Rooms

A locally hosted platform to manage the rooms within your smart home. Integrates with HomeAssistant, NodeRed, and MQTT.

## Prerequisites

- Ruby 3.1.2
- Rails 7


## To build/install locally

```
cd myprojects
git clone https://github.com/deevis/smart_rooms.git
cd smart_rooms
bundle install
rails db:create
rails db:migrate
rails s
```


## Deploy docker container

### Powershell - arm64 target  (raspberry pi, new macbooks...)

```
docker buildx build -f production.Dockerfile --platform linux/arm64 -t smart-rooms-arm64 .
docker image tag smart-rooms-arm64:latest 192.168.1.199:5000/deevis/smart-rooms-arm64:latest
docker image push 192.168.1.199:5000/deevis/smart-rooms-arm64:latest

```

### Branches

- main



