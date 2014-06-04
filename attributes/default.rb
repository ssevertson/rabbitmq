# Latest RabbitMQ.com version to install
default['rabbitmq']['version'] = '3.1.5'
# The distro versions may be more stable and have back-ported patches
default['rabbitmq']['use_distro_version'] = false

# being nil, the rabbitmq defaults will be used
default['rabbitmq']['nodename']  = nil
default['rabbitmq']['address']  = nil
default['rabbitmq']['port']  = nil
default['rabbitmq']['config'] = nil
default['rabbitmq']['logdir'] = nil
default['rabbitmq']['mnesiadir'] = '/var/lib/rabbitmq/mnesia'
default['rabbitmq']['service_name'] = 'rabbitmq-server'

# config file location
# http://www.rabbitmq.com/configure.html#define-environment-variables
# "The .config extension is automatically appended by the Erlang runtime."
default['rabbitmq']['config_root'] = '/etc/rabbitmq'
default['rabbitmq']['config'] = '/etc/rabbitmq/rabbitmq'
default['rabbitmq']['erlang_cookie_path'] = '/var/lib/rabbitmq/.erlang.cookie'

# rabbitmq.config defaults
default['rabbitmq']['default_user'] = 'guest'
default['rabbitmq']['default_pass'] = 'guest'

# Erlang kernel application options
# See http://www.erlang.org/doc/man/kernel_app.html
default['rabbitmq']['kernel']['inet_dist_listen_min'] = nil
default['rabbitmq']['kernel']['inet_dist_listen_max'] = nil

# Tell Erlang what IP to bind to
default['rabbitmq']['kernel']['inet_dist_use_interface'] = nil

# clustering
default['rabbitmq']['cluster'] = false
default['rabbitmq']['cluster_disk_nodes'] = []
default['rabbitmq']['erlang_cookie'] = 'AnyAlphaNumericStringWillDo'
default['rabbitmq']['cluster_partition_handling'] = 'ignore'

# resource usage
default['rabbitmq']['disk_free_limit_relative'] = nil
default['rabbitmq']['vm_memory_high_watermark'] = nil
default['rabbitmq']['max_file_descriptors'] = 1024
default['rabbitmq']['open_file_limit'] = nil

# job control
default['rabbitmq']['job_control'] = 'initd'

# ssl
default['rabbitmq']['ssl']['use'] = false
default['rabbitmq']['ssl']['only'] = true
default['rabbitmq']['ssl']['port'] = 5_671
default['rabbitmq']['ssl']['cacert'] = '/path/to/cacert.pem'
default['rabbitmq']['ssl']['cert'] = '/path/to/cert.pem'
default['rabbitmq']['ssl']['key'] = '/path/to/key.pem'
default['rabbitmq']['ssl']['verify'] = 'verify_none'
default['rabbitmq']['ssl']['fail_if_no_peer_cert'] = false
default['rabbitmq']['ssl']['dist']['port'] = 4_370
default['rabbitmq']['web_console']['use'] = true
default['rabbitmq']['web_console']['ip'] = '0.0.0.0'
default['rabbitmq']['web_console']['port'] = 15_671

# Library versions appropriate for Ubuntu 14.04; would need to be changed for other distros/releases
# These settings are only required to support SSL for distributed Erlang 
default['rabbitmq']['ssl']['erlang']['boot'] = "#{node['rabbitmq']['config_root']}/start_sasl_ssl"
default['rabbitmq']['ssl']['erlang']['version'] = '5.10.4'
default['rabbitmq']['ssl']['erlang']['otp'] = 'OTP  APN 181 01'
default['rabbitmq']['ssl']['erlang']['release'] = 'R16B03'
default['rabbitmq']['ssl']['erlang']['libraries'] = {
  'asn1'       => '2.0.4',
  'crypto'     => '3.2',
  'kernel'     => '2.16.4',
  'public_key' => '0.21',
  'sasl'       => '2.3.4',
  'ssl'        => '5.3.2',
  'stdlib'     => '1.19.4'
}

# tcp listen options
default['rabbitmq']['tcp_listen_packet'] = 'raw'
default['rabbitmq']['tcp_listen_reuseaddr']  = true
default['rabbitmq']['tcp_listen_backlog'] = 128
default['rabbitmq']['tcp_listen_nodelay'] = true
default['rabbitmq']['tcp_listen_exit_on_close'] = false
default['rabbitmq']['tcp_listen_keepalive'] = false

# virtualhosts
default['rabbitmq']['virtualhosts'] = []
default['rabbitmq']['disabled_virtualhosts'] = []

# users
default['rabbitmq']['enabled_users'] =
  [{ :name => 'guest', :password => 'guest', :rights =>
    [{ :vhost => nil , :conf => '.*', :write => '.*', :read => '.*' }]
  }]
default['rabbitmq']['disabled_users'] = []

# plugins
default['rabbitmq']['enabled_plugins'] = []
default['rabbitmq']['disabled_plugins'] = []

# platform specific settings
case node['platform_family']
when 'smartos'
  default['rabbitmq']['service_name'] = 'rabbitmq'
  default['rabbitmq']['config_root'] = '/opt/local/etc/rabbitmq'
  default['rabbitmq']['config'] = '/opt/local/etc/rabbitmq/rabbitmq'
  default['rabbitmq']['erlang_cookie_path'] = '/var/db/rabbitmq/.erlang.cookie'
end

# Example HA policies
default['rabbitmq']['policies']['ha-all']['pattern'] = '^(?!amq\\.).*'
default['rabbitmq']['policies']['ha-all']['params'] = { 'ha-mode' => 'all' }
default['rabbitmq']['policies']['ha-all']['priority'] = 0

default['rabbitmq']['policies']['ha-two']['pattern'] = "^two\."
default['rabbitmq']['policies']['ha-two']['params'] = { 'ha-mode' => 'exactly', 'ha-params' => 2 }
default['rabbitmq']['policies']['ha-two']['priority'] = 1

default['rabbitmq']['disabled_policies'] = []
