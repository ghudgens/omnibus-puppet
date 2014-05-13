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
name "libedit"
default_version "20130712-3.1"
homepage "http://thrysoee.dk/editline/"

dependency "ncurses"

version "20130712-3.1" do
  source md5: "0891336c697362727a1fa7e60c5cb96c"
end

source url: "http://www.thrysoee.dk/editline/libedit-#{version}.tar.gz"

relative_path "libedit-#{version}"

env = "LDFLAGS" => "-L#{install_dir}/embedded/lib -I#{install_dir}/embedded/include -I#{install_dir}/embedded/include/ncurses",
      "CFLAGS" => "-I#{install_dir}/embedded/include -L#{install_dir}/embedded/lib -I#{install_dir}/embedded/include/ncurses",
      "LD_RUN_PATH" => "#{install_dir}/embedded/lib",
      "LD_OPTIONS" => "-R#{install_dir}/embedded/lib"

build do

  configure_command = ["./configure",
                       "--prefix=#{install_dir}/embedded"]
  command configure_command.join(" "), :env => env
  
  command "make", :env => env
  command "make install", :env => env
end