require "net/http"
require "uri"
# pson is the pure json ruby gem rebundled to aviod conflicts
# require "json"
require "facter"

instanceprofile_role      = ""
instanceprofile_accesskey = ""
instanceprofile_secretkey = ""
instanceprofile_token     = ""

begin
  instanceprofileinfo_ret   = Net::HTTP.get_response(URI.parse("http://169.254.169.254/latest/meta-data/iam/info"))
  if (instanceprofileinfo_ret.code.to_s != "404") then
    instanceprofileinfo_json  = PSON.parse(instanceprofileinfo_ret.body)
    instanceprofile_role      = instanceprofileinfo_json["InstanceProfileArn"].split(":").last.gsub("instance-profile/", "")

    instanceprofile_ret       = Net::HTTP.get_response(URI.parse("http://169.254.169.254/latest/meta-data/iam/security-credentials/" + instanceprofile_role.to_s))
    if (instanceprofileinfo_ret.code.to_s != "404") then
      instanceprofile_json      = PSON.parse(instanceprofile_ret.body)
      instanceprofile_accesskey = instanceprofile_json["AccessKeyId"]
      instanceprofile_secretkey = instanceprofile_json["SecretAccessKey"]
      instanceprofile_token     = instanceprofile_json["Token"]
    end ### if not 404
  end ### if not 404

rescue Errno::EHOSTUNREACH

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

Facter.add(:iam_token) do
  setcode do
    instanceprofile_token
  end ### setcode
end ### Facter

