
  
require "net/http"
require "uri"
require "json"
require "facter"

begin
  instanceprofileinfo_ret   = Net::HTTP.get_response(URI.parse("http://169.254.169.254/latest/meta-data/iam/info"))
  instanceprofileinfo_json  = JSON.parse(instanceprofileinfo_ret.body)
  instanceprofile_role      = instanceprofileinfo_json["InstanceProfileArn"].split(":").last.gsub("instance-profile/", "")
  instanceprofile_ret       = Net::HTTP.get_response(URI.parse("http://169.254.169.254/latest/meta-data/iam/security-credentials/"+instanceprofile_role))
  instanceprofile_json      = JSON.parse(instanceprofile_ret.body)
  instanceprofile_accesskey = instanceprofile_json["AccessKeyId"]
  instanceprofile_secretkey = instanceprofile_json["SecretAccessKey"]
  instanceprofile_token     = instanceprofile_json["Token"]
rescue ### begin

end ### begin rescue

Facter.add(:iam_role) do
  setcode do
    instanceprofile_role
  end ### setcode
end ### Facter

Facter.add(:iam_accesskey) do
  setcode do
    instanceprofile_accesskey
  end ### setcode
end ### Facter

Facter.add(:iam_secretkey) do
  setcode do
    instanceprofile_secretkey
  end ### setcode
end ### Facter




