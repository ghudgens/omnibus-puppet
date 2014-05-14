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

source :path => File.expand_path("files/puppet", Omnibus.project_root)

config_dir = "#{install_dir}/embedded/etc/puppet"
default_dir = "#{install_dir}/embedded/etc/default"
init_dir = "#{install_dir}/embedded/etc/init.d"

build do
  # Generate config if it does not exist.
  command "mkdir -p #{config_dir}"
  unless File.exist?("#{config_dir}/puppet.conf")
    command "cp -a ./puppet.conf #{config_dir}/puppet.conf"
  end

  # Generate default config if it does not exist.
  command "mkdir -p #{default_dir}"
  unless File.exist?("#{default_dir}/puppet")
    command "cp -a ./puppet.default #{default_dir}/puppet"
  end

  # Generate init script if it does not exist.
  command "mkdir -p #{init_dir}"
  unless File.exist?("#{init_dir}/puppet")
    command "cp -a ./puppet.conf #{init_dir}/puppet"
  end
end
