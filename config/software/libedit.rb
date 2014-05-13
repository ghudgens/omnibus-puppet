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
version "20130712-3.1"

dependency "ncurses"

version "20130712-3.1" do
  source md5: "0891336c697362727a1fa7e60c5cb96c"
end

source url: "http://www.thrysoee.dk/editline/libedit-#{version}.tar.gz"

relative_path "libedit-#{version}"

env = case platform
      when "aix"
        {
          "CC" => "xlc -q64",
          "CXX" => "xlC -q64",
          "LD" => "ld -b64",
          "CFLAGS" => "-q64 -I#{install_dir}/embedded/include -O",
          "CXXFLAGS" => "-q64 -I#{install_dir}/embedded/include -O",
          "OBJECT_MODE" => "64",
          "ARFLAGS" => "-X64 cru",
          "M4" => "/opt/freeware/bin/m4",
          "LDFLAGS" => "-q64 -L#{install_dir}/embedded/lib -Wl,-blibpath:#{install_dir}/embedded/lib:/usr/lib:/lib",
        }
      else
        {
          "LDFLAGS" => "-L#{install_dir}/embedded/lib -I#{install_dir}/embedded/include -I#{install_dir}/embedded/include/ncurses",
          "CFLAGS" => "-L#{install_dir}/embedded/lib -I#{install_dir}/embedded/include -I#{install_dir}/embedded/include/ncurses",
          "LD_RUN_PATH" => "#{install_dir}/embedded/lib",
          "LD_OPTIONS" => "-R#{install_dir}/embedded/lib"
        }
      end

build do
  command ["./configure",
           "--prefix=#{install_dir}/embedded"
           ].join(" "), :env => env
  command "make -j #{max_build_jobs}", :env => env
  command "make -j #{max_build_jobs} install"
end