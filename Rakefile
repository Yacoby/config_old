#! /usr/bin/env ruby

require 'colorize'
require 'fileutils'

def update_symlink(original_file, sym_target)
  original_file_path = File.expand_path original_file
  sym_target_path    = File.expand_path sym_target.to_s

  if File.exists? original_file_path
    puts "Removing #{original_file_path}".colorize(:red)
    FileUtils.rm_rf original_file_path
  end

  puts "Symlinking #{original_file_path} -> #{sym_target_path}".colorize(:green)
  FileUtils.symlink sym_target_path, original_file_path
end

def ensure_directory(dependency)
  dependency_path = File.expand_path dependency
  Dir.mkdir dependency_path unless File.exists? dependency_path
end

task :submodules do
  `git submodule init`
  `git submodule foreach git checkout master`
  `git submodule foreach git pull`
end

task :vim => :submodules do
  update_symlink '~/.vimrc', 'vim/.vimrc'
  update_symlink '~/.vim', 'vim'
end

task :tmux => :submodules do
  update_symlink '~/.tmux.conf', 'tmux/.tmux.conf'
  ensure_directory '~/.tmux'
  update_symlink '~/.tmux/plugins', 'tmux/plugins'
end

task :zsh => :submodules do
  ensure_directory File.expand_path(File.join(File.dirname(__FILE__), 'zsh', 'oh-my-zsh', 'custom', 'themes'))
  update_symlink File.expand_path(File.join(File.dirname(__FILE__), 'zsh', 'oh-my-zsh', 'custom', 'themes', 'yacoby.zsh-theme')),
                 File.join('zsh', 'yacoby.zsh-theme')

  update_symlink '~/.oh-my-zsh', 'zsh/oh-my-zsh'
  update_symlink '~/.zshrc', 'zsh/.zshrc'
end

task :xmonad do
  update_symlink '~/.xmonad', 'xmonad'
  update_symlink '~/.xmobarrc', 'xmobar/.xmobarrc'
end

task :git do
  update_symlink '~/.gitconfig', 'git/.gitconfig'
end

task :x do
  update_symlink '~/.xresources', 'x/.xresources'
  update_symlink '~/.xrdb', 'x/xrdb'
end

task :ssh do
  ensure_directory '~/.ssh'
  update_symlink '~/.ssh/config', 'ssh/config'
end

task :default => [:vim, :zsh, :tmux]
