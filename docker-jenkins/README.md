### Jenkins container

#### Pull image
` docker pull sridhav/jenkins`

#### Run jenkins (interactive mode)
` docker run -p 8080:8080  -it sridhav/jenkins`

#### Run jenkins (detached mode)
` docker run -p 8080:8080 -d -t sridhav/jenkins`

#### Exposed ports

|Exposed Ports  | Usage |
|:------------------:| -------- |
|8080 | Jenkins UI port |


#### Additional Setting

The container has ssh installed. SSH keys are located at 

` ls /home/jenkins/.ssh`

The initial admin password for the jenkins is stored at

` /var/lib/jenkins/secrets/initialAdminPassword `



