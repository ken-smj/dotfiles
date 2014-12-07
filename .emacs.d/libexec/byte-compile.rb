#!/usr/bin/ruby
# byte-compile from command line
# Needs Ruby 1.9.x
EMACS = "emacs-snapshot"
GLOBS = ["~/.emacs.el", "~/emacs/init.d/*.el"]
DEFAULT_OPTS = ["-l", "cl", "-L", ".", "-l", File.expand_path("~/emacs/initfuncs.el"),]
def extra_load_path(files)  # extract load-path from init files
  files.map{|file| File.read(file).scan(/add-to.+load-path.+"(.+?)"|push "(.+?)" load-path/) }.flatten.compact
end
load_path_opts = extra_load_path(GLOBS.map{|g| Dir[File.expand_path(g)]}.flatten).map{|f| ["-L", f]}.flatten
exec EMACS, "-Q", "-batch", *load_path_opts, *DEFAULT_OPTS, "-f", "batch-byte-compile", *ARGV
