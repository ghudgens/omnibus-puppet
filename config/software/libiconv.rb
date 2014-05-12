name "libiconv"
default_version "1.14"

dependency "libgcc"

source :url => "http://ftp.gnu.org/pub/gnu/libiconv/libiconv-#{version}.tar.gz",
       :md5 => 'e34509b1623cec449dfeb73d7ce9c6c6'

relative_path "libiconv-#{version}"

env = case platform
      else
        {
          "CFLAGS" => "-L#{install_dir}/embedded/lib -I#{install_dir}/embedded/include",
          "LD_RUN_PATH" => "#{install_dir}/embedded/lib"
        }
      end

build do
  command "./configure --prefix=#{install_dir}/embedded", :env => env
  command "make -j #{max_build_jobs}", :env => env
  command "make -j #{max_build_jobs} install-lib libdir=#{install_dir}/embedded/lib includedir=#{install_dir}/embedded/include", :env => env
end