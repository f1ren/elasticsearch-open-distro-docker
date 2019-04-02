# What is it?
Elasticsearch and Kibana - Probably the cheapest secured production grade cloud setup
## More features
* **Secured** - Authentication and role based access management
* **Many more features** - Since it's [Open Distro for Elasticsearch](https://opendistro.github.io/for-elasticsearch/) there are many more features for you to explore.
## What is missing
* SSL Certificates
* Data recovery plan

# Setup
## AWS EC2
### Launch instance
* [Create new EC2](https://docs.aws.amazon.com/efs/latest/ug/gs-step-one-create-ec2-resources.html) instance as follows.
* Amazon Machine Image (AMI): `Ubuntu Server 18.04 LTS (HVM), SSD Volume Type`.
* Instance Type: At least `t2.small`.
* Associate [Elastic IP](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/elastic-ip-addresses-eip.html) to your instance.
* Make sure you can [`ssh`](https://medium.com/@GalarnykMichael/aws-ec2-part-2-ssh-into-ec2-instance-c7879d47b6b2) the new instance.
### Troubleshooting
* `Connection timed out` [Read here ](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/TroubleshootingInstancesConnecting.html#TroubleshootingInstancesConnectionTimeout)

Now, [`ssh`](https://medium.com/@GalarnykMichael/aws-ec2-part-2-ssh-into-ec2-instance-c7879d47b6b2) the new EC2 instance and do the following:

## Docker and Docker-Compose
* `sudo apt install docker.io`
* `sudo apt install docker-compose`
## Open Distro `docker-compose`
* `git clone git@github.com:pineur/elasticsearch-open-distro-docker.git`
* `cd elasticsearch-open-distro-docker`
## Increase limit on `mmap` counts
The default operating system limits on `mmap` counts is likely to be too low for Elasticsearch 6.7 ([source](https://www.elastic.co/guide/en/elasticsearch/reference/current/vm-max-map-count.html)). Let's change that:
* `echo "vm.max_map_count=262144" | sudo tee -a /etc/sysctl.conf`
## Change passwords
### Gernerate passwords hash
* `docker-compose up` (Ignore all the errors. We haven't finished yet)
* `docker exec $(docker ps -aqf "name=odfe-node1") /bin/sh /usr/share/elasticsearch/plugins/opendistro_security/tools/hash.sh -p` **[YOUR PASSWORD]**
* Copy the output hash
* `docker-compose down -v` *(DON'T SKIP THIS! It's necessary for the change to take affect)*
### Set the password
* For all users *but* `admin` and `kibanaserver` you will be able to change the password throught Kibana.
* In `internal_users.yml` replace `hash` for users `admin` and `kibanaserver`. You may replace the hash for other users as well.
* In `custom-kibana.yml` replace `CHANGE-THIS` with the *plain* password of `kibanaserver`.
# Open to the world
* `docker-compose up -d`
* `exit`
* [Allow the EC2 instance inbound traffic](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/authorizing-access-to-an-instance.html) on ports:
    * Kibana: `5601`
    * Elasticsearch: `9200`
    * Performance Analyzer: `9600`
# Test
## Elasticsearch
* `curl -XGET --insecure https://`**[instance-ip]**`:9200 -u admin:`**[admin-password]**
## Kibana
* Open http://**[instance-ip]**:5601/
