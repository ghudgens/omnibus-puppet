name "openssl"
version "1.0.1g"

dependency "zlib"
dependency "cacerts"
dependency "makedepend"

version "1.0.1g" do
  source md5: "de62b43dfcd858e66a74bee1c834e959"
end

source :url => "http://www.openssl.org/source/openssl-#{version}.tar.gz",

relative_path "openssl-#{version}"

build do
  patch :source => "openssl-1.0.1f-do-not-build-docs.patch"

  env = case platform
    when "mac_os_x"
      {
        "CFLAGS" => "-arch x86_64 -m64 -L#{install_dir}/embedded/lib -I#{install_dir}/embedded/include -I#{install_dir}/embedded/include/ncurses",
        "LDFLAGS" => "-arch x86_64 -R#{install_dir}/embedded/lib -L#{install_dir}/embedded/lib -I#{install_dir}/embedded/include -I#{install_dir}/embedded/include/ncurses"
      }
    else
      {
        "CFLAGS" => "-I#{install_dir}/embedded/include",
        "LDFLAGS" => "-Wl,-rpath,#{install_dir}/embedded/lib -L#{install_dir}/embedded/lib"
      }
    end

  common_args = [
    "--prefix=#{install_dir}/embedded",
    "--with-zlib-lib=#{install_dir}/embedded/lib",
    "--with-zlib-include=#{install_dir}/embedded/include",
    "no-idea",
    "no-mdc2",
    "no-rc5",
    "zlib",
    "shared",
  ].join(" ")

  configure_command = case platform
    when "mac_os_x"
      ["./Configure",
       "darwin64-x86_64-cc",
       common_args,
      ].join(" ")
    else
      ["./config",
      common_args,
      "disable-gost",  # fixes build on linux, but breaks solaris
      "-L#{install_dir}/embedded/lib",
      "-I#{install_dir}/embedded/include",
      "-Wl,-rpath,#{install_dir}/embedded/lib"].join(" ")
    end

  # openssl build process uses a `makedepend` tool that we build inside the bundle.
  env["PATH"] = "#{install_dir}/embedded/bin" + File::PATH_SEPARATOR + ENV["PATH"]

  make_binary = 'make'

  command configure_command, :env => env
  command "#{make_binary} depend", :env => env
  # make -j N on openssl is not reliable
  command "#{make_binary}", :env => env
  command "#{make_binary} install", :env => env
end