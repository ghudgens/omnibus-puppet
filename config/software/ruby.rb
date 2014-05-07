# This is an example software definition for a Ruby project.
#
# Lots of software definitions for popular open source software
# already exist in `opscode-omnibus`:
#
#  https://github.com/opscode/omnibus-software/tree/master/config/software
#
name "ruby"
version "2.0.0-p451"
homepage "http://www.ruby-lang.org/"

dependency "zlib"
dependency "ncurses"
dependency "libedit"
dependency "openssl"
dependency "libyaml"
dependency "libiconv"
dependency "gdbm"
dependency "libgcc"

version "2.0.0-p451" do
  source sha256: "5bf8a1c7616286b9dbc962912c3f58e67bc3a70306ca90b0882ef0bd442e02f5"
end

source url: "http://cache.ruby-lang.org/pub/ruby/#{version.match(/^(\d+\.\d+)/)[0]}/ruby-#{version}.tar.gz"

env =
  case platform
  when "mac_os_x"
    {
      # -Qunused-arguments suppresses "argument unused during compilation"
      # warnings. These can be produced if you compile a program that doesn't
      # link to anything in a path given with -Lextra-libs. Normally these
      # would be harmless, except that autoconf treats any output to stderr as
      # a failure when it makes a test program to check your CFLAGS (regardless
      # of the actual exit code from the compiler).
      "CFLAGS" => "-arch x86_64 -m64 -L#{install_dir}/embedded/lib -I#{install_dir}/embedded/include -I#{install_dir}/embedded/include/ncurses -O3 -g -pipe -Qunused-arguments",
      "LDFLAGS" => "-arch x86_64 -L#{install_dir}/embedded/lib -I#{install_dir}/embedded/include -I#{install_dir}/embedded/include/ncurses"
    }
  else
    {
      "CFLAGS" => "-I#{install_dir}/embedded/include -O3 -g -pipe",
      "LDFLAGS" => "-Wl,-rpath,#{install_dir}/embedded/lib -L#{install_dir}/embedded/lib"
    }
  end

build do
  configure_command = ["./configure",
                       "--prefix=#{install_dir}/embedded",
                       "--with-out-ext=fiddle,dbm",
                       "--enable-shared",
                       "--enable-libedit",
                       "--with-ext=psych",
                       "--disable-install-doc"]


  env.merge!({
    "RUBYOPT"         => nil,
    "BUNDLE_BIN_PATH" => nil,
    "BUNDLE_GEMFILE"  => nil,
    "GEM_PATH"        => nil,
    "GEM_HOME"        => nil
  })

  #Check for gmake
  has_gmake = system("gmake --version")

  if has_gmake
    env.merge!({'MAKE' => 'gmake'})
    make_binary = 'gmake'
  else
    make_binary = 'make'
  end

  command configure_command.join(" "), :env => env
  command "#{make_binary} -j #{max_build_jobs}", :env => env
  command "#{make_binary} -j #{max_build_jobs} install", :env => env
end