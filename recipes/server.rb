# notifies :action, 'recipe[name]', :timer
# subscribe :action, 'resource[name]', :timer
#  :before, :delayed, :immediately

package 'httpd' do
  action:install
end

#cookbook_file '/var/www/html/index.html' do
 # source 'index.html'
#end

remote_file '/var/www/html/cheetah.jpg' do
  source 'http://elelur.com/data_images/mammals/cheetah/cheetah-04.jpg'
end

#bash "inline script" do
#  user "root"
#  code "mkdir -p /var/www/mysites/ && chown -R apache /var/www/mysites/"
#  not_if '[ -d /var/www/mysites/ ]'
#  not_if do
#    File.directory?('/var/www/mysites/')
#  end
#end

#execute "run a script" do
#  user "root"
#  command <<-EOH
#  mkdir -p /var/www/mysites /
#  chown -R apache /var/www/mysites/
#  EOH
#  not_if do
#  File.directory?('/var/www/mysites/')
#  end
#end

#execute "run script" do
#  user "root"
#  command './myscript.sh'
#  not_if 
#end

directory "/var/www/mysites" do
  owner 'apache'
  recursive true
  mode
end

template '/var/www/html/index.html' do
  source 'index.html.erb'
#  notifies :restart, 'service[httpd]', :immediately
end

service 'httpd' do
  action [ :enable, :start]
  subscribes :restart, 'template[/var/wwww/html/index.html]', :immediately
end



