name "cacerts"
default_version "2014.04.22"  # date of the file is in a comment at the start, or in the changelog

source :url => "http://curl.haxx.se/ca/cacert.pem",
       :md5 => "9f92a0d9f605e227ae068e605f4c86fa"

relative_path "cacerts-#{version}"

build do
  block do
    FileUtils.mkdir_p(File.expand_path("embedded/ssl/certs", install_dir))

    # There is a bug in omnibus-ruby that may or may not have been fixed. Since the source url
    # does not point to an archive, omnibus-ruby tries to copy cacert.pem into the project working
    # directory. However, it fails and copies to '/var/cache/omnibus/src/cacerts-2012.12.19\' instead
    # There is supposed to be a fix in omnibus-ruby, but under further testing, it was unsure if the
    # fix worked. Rather than trying to fix this now, we're filing a bug and copying the cacert.pem
    # directly from the cache instead.

    FileUtils.cp(File.expand_path("cacert.pem", Omnibus.config.cache_dir),
                 File.expand_path("embedded/ssl/certs/cacert.pem", install_dir))
  end

  unless platform == 'windows'
    command "ln -sf #{install_dir}/embedded/ssl/certs/cacert.pem #{install_dir}/embedded/ssl/cert.pem"
  end
end