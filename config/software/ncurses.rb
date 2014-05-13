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
name "ncurses"
default_version "5.9"
homepage "http://www.ruby-lang.org/"

version "5.9" do
  source md5: "8cb9c412e5f2d96bc6f459aa8c6282a1"
end

source url: "http://ftp.gnu.org/gnu/ncurses/ncurses-#{version}.tar.gz",

relative_path "ncurses-#{version}"

env = "LDFLAGS" => "-L#{install_dir}/embedded/lib -I#{install_dir}/embedded/include",
      "CFLAGS" => "-L#{install_dir}/embedded/lib -I#{install_dir}/embedded/include",
      "LD_RUN_PATH" => "#{install_dir}/embedded/lib"

build do
  configure_command = ["./configure",
                       "--prefix=#{install_dir}/embedded",
                       "--with-shared",
                       "--with-termlib",
                       "--without-debug",
                       "--enable-overwrite"]
  command configure_command.join(" "), :env => env
  
  command "make", :env => env
  command "make install", :env => env
end