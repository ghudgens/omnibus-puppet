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
name "cacerts"
version "2014.04.22"  # date of the file is in a comment at the start, or in the changelog
homepage "http://curl.haxx.se/"

version "2014.04.22" do
  source md5: "9f92a0d9f605e227ae068e605f4c86fa"
end

source url: "http://curl.haxx.se/ca/cacert.pem"

relative_path "cacerts-#{version}"

build do
  block do
    FileUtils.mkdir_p(File.expand_path("embedded/ssl/certs", install_dir))

    FileUtils.cp(File.expand_path("cacert.pem", Omnibus.config.cache_dir),
                 File.expand_path("embedded/ssl/certs/cacert.pem", install_dir))
  end

  unless platform == 'windows'
    command "ln -sf #{install_dir}/embedded/ssl/certs/cacert.pem #{install_dir}/embedded/ssl/cert.pem"
  end
end