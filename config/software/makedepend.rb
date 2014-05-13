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
name "makedepend"
default_version "1.0.5"
homepage "http://www.xfree86.org/current/makedepend.1.html"

dependency "xproto"
dependency "util-macros"
dependency "pkg-config"

version "1.0.5" do
  source md5: "efb2d7c7e22840947863efaedc175747"
end

source url: "http://downloads.sourceforge.net/project/libpng/zlib/#{version}/zlib-#{version}.tar.gz"

relative_path "makedepend-#{version}"

env = "LDFLAGS" => "-L#{install_dir}/embedded/lib -I#{install_dir}/embedded/include",
      "CFLAGS" => "-L#{install_dir}/embedded/lib -I#{install_dir}/embedded/include",
      "PKG_CONFIG_PATH" => "#{install_dir}/embedded/lib/pkgconfig" + File::PATH_SEPARATOR + "#{install_dir}/embedded/share/pkgconfig",
      "PATH" => "#{install_dir}/embedded/bin" + File::PATH_SEPARATOR + ENV["PATH"]

build do
  configure_command = ["./configure",
                       "--prefix=#{install_dir}/embedded"]
  command configure_command.join(" "), :env => env
  
  command "make", :env => env
  command "make install", :env => env
end