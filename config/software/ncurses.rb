name "ncurses"
version "5.9"

version "5.9" do
  source md5: "8cb9c412e5f2d96bc6f459aa8c6282a1"
end

source url: "http://ftp.gnu.org/gnu/ncurses/ncurses-#{version}.tar.gz",

relative_path "ncurses-#{version}"

env = "LD_RUN_PATH" => "#{install_dir}/embedded/lib",
      "CFLAGS" => "-L#{install_dir}/embedded/lib -I#{install_dir}/embedded/include",
      "LDFLAGS" => "-L#{install_dir}/embedded/lib"


########################################################################
#
# wide-character support:
# Ruby 1.9 optimistically builds against libncursesw for UTF-8
# support. In order to prevent Ruby from linking against a
# package-installed version of ncursesw, we build wide-character
# support into ncurses with the "--enable-widec" configure parameter.
# To support other applications and libraries that still try to link
# against libncurses, we also have to create non-wide libraries.
#
# The methods below are adapted from:
# http://www.linuxfromscratch.org/lfs/view/development/chapter06/ncurses.html
#
########################################################################

build do
  if platform == "mac_os_x"
    # References:
    # https://github.com/Homebrew/homebrew-dupes/issues/43
    # http://invisible-island.net/ncurses/NEWS.html#t20110409
    #
    # Patches ncurses for clang compiler. Changes have been accepted into
    # upstream, but occurred shortly after the 5.9 release. We should be able
    # to remove this after upgrading to any release created after June 2012
    patch :source => 'ncurses-clang.patch'
  end

  # build wide-character libraries
  cmd_array = ["./configure",
           "--prefix=#{install_dir}/embedded",
           "--with-shared",
           "--with-termlib",
           "--without-debug",
           "--without-normal", # AIX doesn't like building static libs
           "--enable-overwrite",
           "--enable-widec"]

  cmd_array << "--with-libtool" if platform == 'aix'
  command(cmd_array.join(" "), :env => env)
  command "make -j #{max_build_jobs}", :env => env
  command "make -j #{max_build_jobs} install", :env => env

  # build non-wide-character libraries
  command "make distclean"
  cmd_array = ["./configure",
           "--prefix=#{install_dir}/embedded",
           "--with-shared",
           "--with-termlib",
           "--without-debug",
           "--without-normal",
           "--enable-overwrite"]
  command(cmd_array.join(" "), :env => env)
  command "make -j #{max_build_jobs}", :env => env

  # installing the non-wide libraries will also install the non-wide
  # binaries, which doesn't happen to be a problem since we don't
  # utilize the ncurses binaries
  command "make -j #{max_build_jobs} install", :env => env

end