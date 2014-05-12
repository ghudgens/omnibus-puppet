name "pkg-config"
default_version "0.28"

source :url => 'http://pkgconfig.freedesktop.org/releases/pkg-config-0.28.tar.gz',
  :md5 => 'aa3c86e67551adc3ac865160e34a2a0d'

relative_path 'pkg-config-0.28'

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

paths = [ "#{install_dir}/embedded/bin/pkgconfig" ]

build do
  command "./configure --prefix=#{install_dir}/embedded --disable-debug --disable-host-tool --with-internal-glib --with-pc-path=#{paths*':'}", :env => configure_env
  command "make -j #{max_build_jobs}", :env => configure_env
  command "make -j #{max_build_jobs} install", :env => configure_env
end