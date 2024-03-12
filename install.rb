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

# sshdir        = "#{ENV['HOME']}/.ssh"
# shhdir_config = "#{sshdir}/config"
# system "mkdir #{sshdir}" unless File.directory?(sshdir)
# system "mv -f #{shhdir_config} #{shhdir_config}.bak" if File.exists?(shhdir_config)
# system "ln -sf #{pwd}/ssh/config #{shhdir_config}"

# Setup NeoVim

system 'mkdir -p $HOME/.config'
system 'ln -nfs nvim $HOME/.config/nvim'
