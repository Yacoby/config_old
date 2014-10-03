#! /usr/bin/env ruby

require 'fileutils'
require 'optparse'

def update_symlink(original_file, sym_target)
  original_file_path = File.expand_path original_file
  sym_target_path    = File.expand_path(File.join(File.dirname(__FILE__), sym_target.to_s))

  if File.exists? original_file_path
    puts "Removing #{original_file_path}"
    FileUtils.rm_rf original_file_path
  end

  puts "Symlinking #{original_file_path} -> #{sym_target_path}"
  FileUtils.symlink sym_target_path, original_file_path
end

def ensure_directory(dependency)
  dependency_path = File.expand_path dependency
  Dir.mkdir dependency_path unless File.exists? dependency_path
end

use_git = false
use_xmonad = false
use_x = false
use_ssh = false

use_vim = true
use_zsh = true

OptionParser.new do |o|
  o.on('--git') { use_git= true }
  o.on('--xmonad') { use_xmonad = true  }
  o.on('--x') { use_x = true }
  o.on('--ssh') { use_ssh = true }

  o.on('--novim') { use_vim = false }
  o.on('--nozsh') { use_zsh = false }
  o.parse!
end

if !no_vim
  update_symlink '~/.vimrc', 'vim/.vimrc'
  update_symlink '~/.vim', 'vim'
end

if !no_zsh
  update_symlink '~/.oh-my-zsh', 'zsh/oh-my-zsh'
  update_symlink '~/.zshrc', 'zsh/.zshrc'
end

if use_xmonad
  update_symlink '~/.xmonad', 'xmonad'
  update_symlink '~/.xmobarrc', 'xmobar/.xmobarrc'
end

if use_git
  update_symlink '~/.gitconfig', 'git/.gitconfig'
end

if use_x
  update_symlink '~/.xresources', 'x/.xresources'
  update_symlink '~/.xrdb', 'x/xrdb'
end

if use_ssh
  ensure_directory '~/.ssh'
  update_symlink '~/.ssh/config', 'ssh/config'
end
