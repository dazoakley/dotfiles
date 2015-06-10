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

vundledir = "#{vimdir}/bundle/vundle"
unless File.directory?(vundledir)
  system "git clone http://github.com/gmarik/vundle.git #{vundledir}"
end

# Symlink nginx/apache conf

system "cd /usr/local/etc/nginx && sudo rm nginx.conf && sudo ln -nfs ~/projects/dotfiles/nginx.conf nginx.conf"
system "cd /etc/apache2/extra && sudo rm httpd-vhosts.conf && sudo ln -nfs ~/projects/dotfiles/apache-vhosts.conf httpd-vhosts.conf"

# Syslog local0 facility setup

syslog_conf_file = '/etc/syslog.conf'
syslog_log_file  = '/var/log/local.log'
syslog_str       = "local0.* #{syslog_log_file}"

system "sudo touch #{syslog_log_file}"
system "sudo chown root:admin #{syslog_log_file}"

unless File.read(syslog_conf_file).include?(syslog_str)
  puts %Q{
    To complete the syslog setup you now need to add the following line to '#{syslog_conf_file}':

    #{syslog_str}

    Then run the following commands:

    sudo launchctl unload /System/Library/LaunchDaemons/com.apple.syslogd.plist
    sudo launchctl load /System/Library/LaunchDaemons/com.apple.syslogd.plist
  }
end
