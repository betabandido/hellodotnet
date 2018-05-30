# hellodotnet
Sample .NET core dockerized application

## Building the Image

Execute the following command to run the unit tests and build the Docker image containing the application:

```bash
docker build -t hellodotnet .
```

## Running the Application

To run the application execute:

```bash
docker run -it --rm -p 8080:80 hellodotnet
```

Then, access the greeting endpoint:

```bash
curl localhost:8080/api/greeting/en
```
