### Spark standalone

#### Pull image
` docker pull sridhav/spark`

#### Run spark (interactive mode)
` docker run -p 8080:8080 -p 7077:7077 -it sridhav/spark`

#### Run spark (detached mode)
` docker run -p 8080:8080 -p 7077:7077 -d -t sridhav/spark`

#### Exposed ports

|Exposed Ports  | Usage |
|:------------------:| -------- |
|8080 | Spark Master UI port |
|7077| Spark Master Service port to listen on|

Note: random ports gets assigned to workers to listen on



