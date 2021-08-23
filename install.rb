#!/usr/bin/env ruby

pwd = Dir.pwd

# Symlink the dotfiles...

Dir.glob('\.*').each do |source|
  next unless File.file?(source)
  target = "#{ENV['HOME']}/#{source}"
  system "mv -f #{target} #{target}.bak" if File.exists?(target)
  system "ln -sf #{pwd}/#{source} #{target}"
end

# My SSH setup...

sshdir        = "#{ENV['HOME']}/.ssh"
shhdir_config = "#{sshdir}/config"
system "mkdir #{sshdir}" unless File.directory?(sshdir)
system "mv -f #{shhdir_config} #{shhdir_config}.bak" if File.exists?(shhdir_config)
system "ln -sf #{pwd}/ssh/config #{shhdir_config}"

# My vim setup...
#
# - make the directories
# - symlink in custom color schemes (that can't be managed by vundle)
# - install vundle

vimdir = "#{ENV['HOME']}/.vim"
Dir.mkdir(vimdir) unless File.directory?(vimdir)

['bundle','backup','colors','undo'].each do |dir|
  target = "#{vimdir}/#{dir}"
  Dir.mkdir(target) unless File.directory?(target)
end

Dir.glob('vim-colors/*') do |source|
  target = "#{vimdir}/#{source.sub('vim-','')}"
  system "mv -f #{target} #{target}.bak" if File.exists?(target)
  system "ln -sf #{pwd}/#{source} #{target}"
end

vundledir = "#{vimdir}/bundle/Vundle.vim"
unless File.directory?(vundledir)
  system "git clone http://github.com/VundleVim/Vundle.vim.git #{vundledir}"
end

# Setup NeoVim

system 'mkdir -p ${XDG_CONFIG_HOME:=$HOME/.config}'
system 'ln -s ~/.vim $XDG_CONFIG_HOME/nvim'
system 'ln -s ~/.vimrc $XDG_CONFIG_HOME/nvim/init.vim'

# Setup homebrew symlink (so stuff works on M1 and x86 arch)

system 'sudo ln -nfs /usr/local /opt/homebrew'
