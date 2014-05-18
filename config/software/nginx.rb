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
name "nginx"
default_version "1.6.0"

dependency "ruby"
dependency "passenger-gem"
dependency "pcre"
dependency "openssl"

version "1.4.4" do
  source md5: "5dfaba1cbeae9087f3949860a02caa9f"
end

version "1.4.7" do
  source md5: "aee151d298dcbfeb88b3f7dd3e7a4d17"
end

version "1.6.0" do
  source md5: "8efa354f1c3c2ccf434a50d3fbe82340"
end

source url: "http://nginx.org/download/nginx-#{version}.tar.gz"

relative_path "nginx-#{version}"

env = { "LDFLAGS" => "-L#{install_dir}/embedded/lib -I#{install_dir}/embedded/include",
        "CFLAGS" => "-L#{install_dir}/embedded/lib -I#{install_dir}/embedded/include",
        "LD_RUN_PATH" => "#{install_dir}/embedded/lib"}

build do
  configure_command = ["./configure",
                       "--prefix=#{install_dir}/embedded",
                       "--conf-path=#{install_dir}/embedded/etc/nginx/nginx.conf",
                       "--pid-path=/var/run/nginx.pid",
                       "--error-log-path=/var/log/puppet/nginx/error.log",
                       "--http-log-path=/var/log/puppet/nginx/access.log",
                       "--with-http_ssl_module",
                       "--with-http_stub_status_module",
                       "--with-http_gzip_static_module",
                       "--add-module=`#{install_dir}/embedded/bin/passenger-config --root`/ext/nginx",
                       "--with-debug"]

  command configure_command.join(" "), :env => env
  
  command "make", :env => env
  command "make install", :env => env
end