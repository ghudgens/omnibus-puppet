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
name "libiconv"
default_version "1.14"
homepage "https://www.gnu.org/software/libiconv/"

version "1.14" do
  source md5: "e34509b1623cec449dfeb73d7ce9c6c6"
end

source url: "http://ftp.gnu.org/pub/gnu/libiconv/libiconv-#{version}.tar.gz"

relative_path "libiconv-#{version}"

env = "LDFLAGS" => "-L#{install_dir}/embedded/lib -I#{install_dir}/embedded/include",
      "CFLAGS" => "-L#{install_dir}/embedded/lib -I#{install_dir}/embedded/include",
      "LD_RUN_PATH" => "#{install_dir}/embedded/lib"

build do
  configure_command = ["./configure",
                       "--prefix=#{install_dir}/embedded"]
  command configure_command.join(" "), :env => env
  
  command "make", :env => env
  command "make install-lib libdir=#{install_dir}/embedded/lib includedir=#{install_dir}/embedded/include", :env => env
end