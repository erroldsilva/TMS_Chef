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

file "#{home}/TMS" do
  action :create_if_missing
end


bash "TMS_DEPLOY" do
     
     cwd "#{home}/TMS"
     code <<-EOH
       wget http://mirrors.ibiblio.org/apache/tomcat/tomcat-7/v7.0.27/bin/apache-tomcat-7.0.27.tar.gz
       tar -xzf apache-tomcat-7.0.27.tar.gz
       chown -R webadmin:webadmin /opt/apps
     EOH
     not_if "test -d /opt/apps/apache-tomcat-7.0.27"
end
