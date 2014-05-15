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
name "apr-util"
default_version "1.5.3"

dependency "openssl"
dependency "gdbm"

version "1.5.3" do
  source md5: "71a11d037240b292f824ba1eb537b4e3"
end

source url: "http://apache.mirror.quintex.com/apr/apr-util-#{version}.tar.gz"

relative_path "apr-util-#{version}"

env = { "LDFLAGS" => "-L#{install_dir}/embedded/lib -I#{install_dir}/embedded/include",
        "CFLAGS" => "-L#{install_dir}/embedded/lib -I#{install_dir}/embedded/include",
        "PATH" => "#{install_dir}/embedded/bin:#{ENV["PATH"]}"}

build do
  # Ensure the following directories exist
  
  configure_command = ["./configure",
                       "--prefix=#{install_dir}/embedded"]

  command configure_command.join(" "), :env => env
  
  command "make", :env => env
  command "make install", :env => env
end