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
name "openssl"
default_version "1.0.1g"
homepage "http://www.openssl.org/"

dependency "zlib"
dependency "cacerts"
dependency "makedepend"

version "1.0.1g" do
  source md5: "de62b43dfcd858e66a74bee1c834e959"
end

source :url => "http://www.openssl.org/source/openssl-#{version}.tar.gz",

relative_path "openssl-#{version}"

env = "LDFLAGS" => "-Wl,-rpath #{install_dir}/embedded/lib -L#{install_dir}/embedded/lib -I#{install_dir}/embedded/include",
      "CFLAGS" => "-I#{install_dir}/embedded/include -L#{install_dir}/embedded/lib",
      "PATH" => "#{install_dir}/embedded/bin" + File::PATH_SEPARATOR + ENV["PATH"]

build do
  patch :source => "openssl-1.0.1f-do-not-build-docs.patch"

  configure_command = ["./config",
                       "--prefix=#{install_dir}/embedded",
                       "--with-zlib-lib=#{install_dir}/embedded/lib",
                       "--with-zlib-include=#{install_dir}/embedded/include",
                       "no-idea",
                       "no-mdc2",
                       "no-rc5",
                       "zlib",
                       "shared",
                       "disable-gost"]
  command configure_command.join(" "), :env => env
  
  command "make depend", :env => env
  command "make", :env => env
  command "make install", :env => env
end