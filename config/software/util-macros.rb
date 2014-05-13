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
name "util-macros"
default_version "1.18.0"
homepage "http://http://www.x.org/"

version "1.18.0" do
  source md5: "fd0ba21b3179703c071bbb4c3e5fb0f4"
end

source url: "http://xorg.freedesktop.org/releases/individual/util/util-macros-#{version}.tar.gz"

relative_path "util-macros-#{version}"

env = "LDFLAGS" => "-L#{install_dir}/embedded/lib -I#{install_dir}/embedded/include",
      "CFLAGS" => "-L#{install_dir}/embedded/lib -I#{install_dir}/embedded/include"

build do
  configure_command = ["./configure",
                       "--prefix=#{install_dir}/embedded"]
  command configure_command.join(" "), :env => env
  
  command "make", :env => env
  command "make install", :env => env
end