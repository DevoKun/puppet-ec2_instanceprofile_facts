EC2 Instance Profile Facts
==========================

## EC2 UserData Fact
### Facts
* user_data
* asgard_user_data
* in_ec2

### Raw UserData fact
* ***user_data*** Contains the raw, unparsed, contents of the ***EC2 UserData***.

### Asgard UserData fact
* Netflix Asgard will set the userdata of an instance to be a set of bash variables that can be used by init scripts on that instance.
```bash
export EC2_REGION=us-east-1
export CLOUD_COUNTRIES=useast1
export CLOUD_DEV_PHASE=prod
export CLOUD_APPLICATION=webserver
export CLOUD_REVISION=547
```
* Facter takes the spaces and converts them in to spaces and effectively makes the userdata difficult to work with if you want to pull the variables in to a puppet manifest.
```bash
facter ec2_userdata
```


```raw
export
EC2_REGION=us-east-1
export
CLOUD_COUNTRIES=useast1
export
CLOUD_DEV_PHASE=prod
export
CLOUD_APPLICATION=webserver
export
CLOUD_REVISION=547
```

* In the event that you are using an Asgard-style UserData format, the ***asgard_user_data*** fact converts the bash variable list in to a hash usable by puppet.


## EC2 InstanceProfile Facts
* Takes the Instance-Profile data from the instance metadata Some AWS SDKs, like Ruby, do not need the keys in their configuration because the SDK has been configured to pull directly from the InstanceProfile information in the metadata.
* However, some clients like ActiveMQ that are not instance profile aware will fail if keys are not included in the configuration file.

### Facts
* iam_role
* iam_accesskey
* iam_secretkey


## Install Module from github with Librarian-Puppet
* Librarian-puppet. It is an extension of ruby’s bundler model to install gems, having a file that defines your dependencies, Gemfile in the case of bundler, Puppetfile in the case of librarian, and a .lock file with the resolved dependencies.

### Install librarian-puppet
```bash
gem install librarian-puppet
```
***FILE:*** /etc/puppet/Puppetfile

### Install puppet modules from Puppetfile

```yaml
mod "devokun-ec2_instanceprofile_facts",
  :git => "https://github.com/DevoKun/puppet-ec2_instanceprofile_facts.git",
  :ref => 'master'
```


```bash
cd /etc/puppet
librarian-puppet install
```


