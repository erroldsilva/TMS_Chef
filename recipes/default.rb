#
# Cookbook Name:: TMS_Deploy
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

#user = node['mycookbook']['user'] # user set in cookbook attrubute
user = node['current_user'] # user running chef cookbook (on provisioned host)

home = node['etc']['passwd'][user]['dir'] # Chef DSL
# home = Dir.home(user) # It's Ruby

directory "#{home}/TMS" do
  action :create
end


git "#{home}/TMS" do
   repository "https://github.com/erroldsilva/TMS.git"
   reference "master"
   action :export
end

bash "install_TMS" do
   cwd "#{home}/TMS"
   code <<-EOH
     
     sudo npm install
     node app
   EOH
end

