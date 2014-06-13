#
# Cookbook Name:: TMS_Deploy
# Recipe:: default
#
# Copyright 2014, Errol Dsilva
#
# No rights reserved - Feel free to Redistribute
#

user = node['current_user'] # user running chef cookbook (on provisioned host)

home = node['etc']['passwd'][user]['dir'] # Chef DSL

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

