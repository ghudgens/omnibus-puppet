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
name "apr"
default_version "1.5.1"

version "1.5.1" do
  source md5: "d3538d67e6455f48cc935d8f0a50a1c3"
end

source url: "http://apache.mirror.quintex.com/apr/apr-#{version}.tar.gz"

relative_path "apr-#{version}"

env = { "LDFLAGS" => "-L#{install_dir}/embedded/lib -I#{install_dir}/embedded/include",
        "CFLAGS" => "-L#{install_dir}/embedded/lib -I#{install_dir}/embedded/include",
        "PATH" => "#{install_dir}/embedded/bin:#{ENV["PATH"]}"}

build do
  # Ensure the following directories exist
  
  configure_command = ["./configure",
                       "--prefix=#{install_dir}/embedded",
                       "--with-installbuilddir=#{install_dir}/embedded/share/apr-1/build"]

  command configure_command.join(" "), :env => env
  
  command "make", :env => env
  command "make install", :env => env
end