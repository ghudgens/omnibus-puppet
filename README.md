Puppet Omnibus project
======================
This project creates full-stack platform-specific packages for `puppet` and `puppetmaster`!

As this project was designed to be used in a more "enterprisey" environment, the following are implemented: 
* All dependencies, including Ruby, listed in a project are locked to a specific version override.
* The puppetmaster package configures Unicorn and Nginx to handle larger agent loads.

Installation
------------
You must have a sane Ruby 1.9+ environment with Bundler installed. Ensure all
the required gems are installed:

```shell
$ bundle install --binstubs
```

Usage
-----
### Build

You create a platform-specific package using the `build project` command:

```shell
$ bin/omnibus build project puppet
```

```shell
$ bin/omnibus build project puppetmaster
```

The platform/architecture type of the package created will match the platform
where the `build project` command is invoked. For example, running this command
on a MacBook Pro will generate a Mac OS X package. After the build completes
packages will be available in the `pkg/` folder.

### Clean

You can clean up all temporary files generated during the build process with
the `clean` command:

```shell
$ bin/omnibus clean
```

Adding the `--purge` purge option removes __ALL__ files generated during the
build including the project install directory (`/opt/puppet`) and
the package cache directory (`/var/cache/omnibus/pkg`):

```shell
$ bin/omnibus clean --purge
```

### Help

Full help for the Omnibus command line interface can be accessed with the
`help` command:

```shell
$ bin/omnibus help
```

### Notes

* Currently only supports Debian.  Ubuntu, CentOS, SLES, Windows, and MacOS will be worked in later.
* Currently only Puppet 3.5.1 is tested.
* Puppet Master build is still todo...
