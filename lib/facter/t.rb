#!/usr/bin/env ruby

require "net/http"
require "uri"
require "json"


  user_data        = Hash.new
  begin
    userdata_ret     = Net::HTTP.get_response(URI.parse("http://169.254.169.254/latest/user-data"))
    userdata_ret.body.gsub("export ", "").split("\n").each do |lin|
      (udkey, udval)   = lin.split("=")
      user_data[udkey] = udval
    end ### each
  #rescue StandardError
  rescue Errno::EHOSTUNREACH
    user_data['not_in_ec2'] = nil
  end

puts "\n--------------------------"
puts user_data
puts "--------------------------\n"


