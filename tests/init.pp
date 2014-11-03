notify { "in_ec2": message=>"
####################################
In EC2 ? ... [${::in_ec2}]
####################################
" }

notify { "iam": message=>"
####################################
IAM Role......: [${::iam_role}]
IAM Access Key: [${::iam_accesskey}]
IAM Secret Key: [${::iam_secretkey}]
####################################
" }

notify { "userdata": message=>"
####################################
UserData..................: [${::user_data}]
Asgard UserData...........: [${::asgard_user_data}]
Asgard UserData In EC2? ... [${::asgard_user_data['in_ec2']}]
####################################
" }

