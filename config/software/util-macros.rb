name "util-macros"
default_version "1.18.0"

source :url => 'http://xorg.freedesktop.org/releases/individual/util/util-macros-1.18.0.tar.gz',
  :md5 => 'fd0ba21b3179703c071bbb4c3e5fb0f4'

relative_path 'util-macros-1.18.0'

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

build do
  command "./configure --prefix=#{install_dir}/embedded", :env => configure_env
  command "make -j #{max_build_jobs}", :env => configure_env
  command "make -j #{max_build_jobs} install", :env => configure_env
end