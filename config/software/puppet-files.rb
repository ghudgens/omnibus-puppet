#
# Copyright:: Copyright (c) 2014 Grant Hudgens.
# License:: Apache License, Version 2.0
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
name "puppet-files"

dependency "puppet-gem"
dependency "nginx-files"

files_dir   = File.expand_path("files/puppet", Omnibus.project_root)
config_dir  = "#{install_dir}/embedded/etc/puppet"
default_dir = "#{install_dir}/embedded/etc/default"
init_dir    = "#{install_dir}/embedded/etc/init.d"
webapp_dir  = "#{install_dir}/embedded/share/puppet"

build do
  # Generate config directories.
  command "mkdir -p #{config_dir}"
  command "rm -f #{config_dir}/*"
  command "mkdir -p #{config_dir}/environments"
  command "mkdir -p #{config_dir}/manifests"
  command "mkdir -p #{config_dir}/modules"
  command "mkdir -p #{config_dir}/templates"

  if project.name == "puppetmaster"
    #Generate Puppet configuration file.
    command "cp -a #{files_dir}/puppet.conf.master #{config_dir}/puppet.conf"

    # Generate webapp directory and copy over Rack config.
    command "mkdir -p #{webapp_dir}"
    command "rm -f #{webapp_dir}/*"
    command "mkdir -p #{webapp_dir}/public"
    command "mkdir -p #{webapp_dir}/tmp"
    #command "cp -a #{files_dir}/config.ru #{webapp_dir}/"

    #Generate Nginx server configuration file.
    block do
      template_file = File.open("#{files_dir}/puppetmaster.conf.nginx.erb", "r").read
      nginx_config = ERB.new(template_file)
      File.open("#{install_dir}/embedded/etc/nginx/conf.d/puppetmaster.conf", "w") do |file|
        file.print(nginx_config.result(binding))
      end
    end
  elsif project.name == "puppet"
    #Copy over config file
    command "cp -a #{files_dir}/puppet.conf.agent #{config_dir}/puppet.conf"
  end

  # Generate default config if it does not exist.
  command "mkdir -p #{default_dir}"
  command "rm -f #{default_dir}/puppet"
  command "cp -a #{files_dir}/puppet.default #{default_dir}/puppet"

  # Generate init script if it does not exist.
  command "mkdir -p #{init_dir}"
  command "rm -f #{init_dir}/puppet"
  command "cp -a #{files_dir}/puppet.init #{init_dir}/puppet"
end
