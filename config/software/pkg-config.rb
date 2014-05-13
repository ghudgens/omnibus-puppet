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
name "pkg-config"
default_version "0.28"
homepage "http://www.freedesktop.org/wiki/Software/pkg-config/"

version "0.28" do
  source md5: "aa3c86e67551adc3ac865160e34a2a0d"
end

source url: "http://pkgconfig.freedesktop.org/releases/pkg-config-#{version}.tar.gz"

relative_path "pkg-config-#{version}"

env = "LDFLAGS" => "-L#{install_dir}/embedded/lib -I#{install_dir}/embedded/include",
      "CFLAGS" => "-L#{install_dir}/embedded/lib -I#{install_dir}/embedded/include"

paths = [ "#{install_dir}/embedded/bin/pkgconfig" ]

build do
  configure_command = ["./configure",
                       "--prefix=#{install_dir}/embedded",
                       "--disable-debug",
                       "--disable-host-tool",
                       "--with-internal-glib",
                       "--with-pc-path=#{install_dir}/embedded/bin/pkgconfig"]
  command configure_command.join(" "), :env => env

  command "make", :env => env
  command "make install", :env => env
end