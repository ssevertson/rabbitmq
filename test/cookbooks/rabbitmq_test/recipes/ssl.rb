#
# Cookbook Name:: rabbitmq_test
# Recipe:: ssl
#
# Copyright 2012, Opscode, Inc. <legal@opscode.com>
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

user 'rabbitmq' do
  home '/var/lib/rabbitmq'
  system true
  comment 'RabbitMQ messaging server'
end

group 'ssl-cert' do
  members ['rabbitmq' ]
  system true
  append true
end

cookbook_file 'ca.crt' do
  path '/usr/local/share/ca-certificates/ca.crt'
end
cookbook_file 'server.crt' do
  path '/usr/local/share/ca-certificates/server.crt'
end
cookbook_file 'server.key' do
  path '/etc/ssl/private/server.key'
  group 'ssl-cert'
  mode '0640'
end

execute '/usr/sbin/update-ca-certificates' do
end

directory '/etc/ssl/private' do
  group 'ssl-cert'
  mode '0750'
end

node.set['rabbitmq']['ssl']['use'] = true
node.set['rabbitmq']['ssl']['cacert'] = '/etc/ssl/certs/ca.pem'
node.set['rabbitmq']['ssl']['cert'] = '/etc/ssl/certs/server.pem'
node.set['rabbitmq']['ssl']['key'] = '/etc/ssl/private/server.key'

include_recipe 'rabbitmq::default'

