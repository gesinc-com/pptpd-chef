include_recipe 'yum-epel'
include_recipe 'iptables'
include_recipe 'sysctl'

package 'pptpd' do
  action :install
end

service 'pptpd' do
  supports status: true, restart: true
  action [:start, :enable]
end

template '/etc/pptpd.conf' do
  source 'pptpd.conf.erb'
  group 'root'
  user 'root'
  mode '0644'
  variables(
    localip: node['pptpd']['localip'],
    remoteip: node['pptpd']['remoteip'],
  )
  notifies :restart, 'service[pptpd]'
end

template '/etc/ppp/options.pptpd' do
  source 'options.pptpd.erb'
  group 'root'
  user 'root'
  mode '0644'
  notifies :restart, 'service[pptpd]'
end

template '/etc/ppp/chap-secrets' do
  source 'chap-secrets.erb'
  group 'root'
  user 'root'
  mode '0600'
  notifies :restart, 'service[pptpd]'
end

iptables_rule 'pptp' do
  source 'iptables.erb'
end

sysctl_param 'net.ipv4.ip_forward' do
    value 1
end
