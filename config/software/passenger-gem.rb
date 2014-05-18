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
name "passenger-gem"
default_version "4.0.42"

nginx_support = false

dependency "ruby"
dependency "rubygems"

env = { "LDFLAGS" => "-L#{install_dir}/embedded/lib -I#{install_dir}/embedded/include",
        "CFLAGS" => "-L#{install_dir}/embedded/lib -I#{install_dir}/embedded/include",
        "PATH" => "#{install_dir}/embedded/bin:#{ENV['PATH']}"}

build do
  gem "install passenger -n #{install_dir}/embedded/bin --no-rdoc --no-ri -v #{version}"

  if nginx_support == true
    # Compile Phusion Passenger support files for Nginx
    rake "nginx", :env => env
  end
end