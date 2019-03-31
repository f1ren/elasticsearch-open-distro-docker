# What is it?
Secured Elasticsearch and Kibana with [Open Distro for Elasticsearch](https://opendistro.github.io/for-elasticsearch/)

# Setup
## AWS EC2
* [Create new EC2](https://docs.aws.amazon.com/efs/latest/ug/gs-step-one-create-ec2-resources.html) instance as follows.
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
## Increase limit on limits on `mmap` counts
* `echo "vm.max_map_count=262144" | sudo tee -a /etc/sysctl.conf`
## Change passwords
### Gernerate passwords hash
* `docker-compose up` (Ignore all the errors. We haven't finished yet)
* `docker exec $(docker ps -aqf "name=odfe-node1") /bin/sh /usr/share/elasticsearch/plugins/opendistro_security/tools/hash.sh -p` **[YOUR PASSWORD]**
* Copy the output hash
### Set the password
* For all users *but* `admin` and `kibanaserver` you will be able to change the password throught Kibana.
* In `internal_users.yml` replace `hash` for users `admin` and `kibanaserver`. You may replace the hash for other users as well.
* In `custom-kibana.yml` replace `CHANGE-THIS` with the plain password of `kibanaserver`.
* `docker-compose down -v` (DON'T SKIP THAT!)
