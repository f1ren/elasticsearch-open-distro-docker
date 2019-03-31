# What is it?
Secured Elasticsearch and Kibana with Open Distro

# Setup
## AWS EC2
* Amazon Machine Image (AMI): `Ubuntu Server 18.04 LTS (HVM), SSD Volume Type`
* Instance Type: At least `t2.medium`
### Troubleshooting
* `Connection timed out` [Read here ](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/TroubleshootingInstancesConnecting.html#TroubleshootingInstancesConnectionTimeout)
## Docker and Docker-Compose
* `sudo apt install docker.io`
* `sudo apt install docker-compose`
## Open Distro `docker-compose`
* `git clone git@github.com:pineur/elasticsearch-open-distro-docker.git`
* `cd elasticsearch-open-distro-docker`
## Change passwords for read-only users

