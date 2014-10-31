EC2 Instance Profile Facts
==========================

## EC2 UserData Fact
### Fact
* user_data

## EC2 InstanceProfile Facts
* Takes the Instance-Profile data from the instance metadata Some AWS SDKs, like Ruby, do not need the keys in their configuration because the SDK has been configured to pull directly from the InstanceProfile information in the metadata.
* However, some clients like ActiveMQ that are not instance profile aware will fail if keys are not included in the configuration file.

### Facts
* iam_role
* iam_accesskey
* iam_secretkey
