name "makedepend"
default_version "1.0.5"

source :url => 'http://xorg.freedesktop.org/releases/individual/util/makedepend-1.0.5.tar.gz',
  :md5 => 'efb2d7c7e22840947863efaedc175747'

relative_path 'makedepend-1.0.5'

dependency "xproto"
dependency 'util-macros'
dependency 'pkg-config'

configure_env =
  case platform
  when "mac_os_x"
    {
      "LDFLAGS" => "-L#{install_dir}/embedded/lib -I#{install_dir}/embedded/include",
      "CFLAGS" => "-I#{install_dir}/embedded/include -L#{install_dir}/embedded/lib"
    }
  else
    {
      "LDFLAGS" => "-L#{install_dir}/embedded/lib -I#{install_dir}/embedded/include",
      "CFLAGS" => "-I#{install_dir}/embedded/include -L#{install_dir}/embedded/lib"
    }
  end

configure_env["PKG_CONFIG_PATH"] = "#{install_dir}/embedded/lib/pkgconfig" +
  File::PATH_SEPARATOR +
  "#{install_dir}/embedded/share/pkgconfig"

# For pkg-config
configure_env["PATH"] = "#{install_dir}/embedded/bin" + File::PATH_SEPARATOR + ENV["PATH"]

build do
  command "./configure --prefix=#{install_dir}/embedded", :env => configure_env
  command "make -j #{max_build_jobs}", :env => configure_env
  command "make -j #{max_build_jobs} install", :env => configure_env
end