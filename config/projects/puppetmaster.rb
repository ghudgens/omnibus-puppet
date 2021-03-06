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
name 'puppetmaster'
maintainer 'Puppet Labs'
homepage 'http://puppetlabs.com/'

# Package attributes
install_path    '/opt/puppet'
build_version   '3.5.1'
build_iteration 2

# Specify dependency versions to embed
override :'ruby', version: "2.0.0-p451"
override :'augeas-gem', version: "0.5.0"
override :'sinatra-gem', version: "1.4.5"
override :'hiera-gem', version: "1.3.2"
override :'hiera-eyaml-gem', version: "2.0.2"
override :'facter-gem', version: "2.0.1"
override :'passenger-gem', version: "4.0.42"
override :'librarian-puppet-gem', version: "1.0.2"
override :'nginx', version: "1.6.0"
override :'puppet-gem', version: "#{build_version}"

# Creates required build directories
dependency 'preparation'

# Puppet Master dependencies/components
dependency 'librarian-puppet-gem'
dependency 'facter-gem'
dependency 'puppet-gem'
dependency 'augeas-gem'
dependency 'sinatra-gem'
dependency 'hiera-gem'
dependency 'hiera-eyaml-gem'
dependency 'passenger-gem'
dependency 'nginx'

# Puppet Master and its dependencies' configuration/misc files
dependency 'nginx-files'
dependency 'puppet-files'

# Version manifest file
dependency 'version-manifest'

# Ignore git crap
exclude '\.git*'
exclude 'bundler\/git'
