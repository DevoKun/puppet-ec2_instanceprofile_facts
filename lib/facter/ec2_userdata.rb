  
require "net/http"
require "uri"
require "json"
require "facter"



Facter.add(:user_data) do

  begin

    userdata_ret     = Net::HTTP.get_response(URI.parse("http://169.254.169.254/latest/user-data"))
    user_data        = Hash.new
    userdata_ret.body.gsub("export ", "").split("\n").each do |lin|
      (udkey, udval)   = lin.split("=")
      user_data[udkey] = udval
    end ### each


  rescue ### begin

  end ### begin rescue

  setcode do
    user_data
  end ### setcode

end ### Facter.add


