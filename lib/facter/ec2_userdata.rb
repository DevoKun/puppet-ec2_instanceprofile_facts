require "net/http"
require "uri"
require "facter"



user_data           = Hash.new
user_data['in_ec2'] = true
userdata_raw        = ""

begin
  userdata_ret        = Net::HTTP.get_response(URI.parse("http://169.254.169.254/latest/user-data"))
  if (instanceprofileinfo_ret.code.to_s != "404") then
    userdata_raw = userdata_ret.body
  end ### if not 404
rescue Errno::EHOSTUNREACH
  user_data['in_ec2'] = false
end ### begin rescue



Facter.add(:in_ec2) do
  setcode do
    user_data['in_ec2']
  end ### setcode
end ### Facter.add


Facter.add(:user_data) do
  setcode do
    userdata_raw
  end ### setcode
end ### Facter.add

Facter.add(:asgard_user_data) do
  userdata_raw.gsub("export ", "").split(/[\r\n]+).each do |lin|
    (udkey, udval)   = lin.split("=")
    user_data[udkey.gsub(/^ +/, "").gsub(/ +$/, "")] = udval.gsub(/^ +/, "").gsub(/ +$/, "")
  end ### each

  setcode do
    user_data
  end ### setcode
end ### Facter.add

