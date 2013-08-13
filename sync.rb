require 'fileutils'
require 'colored'

def update_symlink(original_file, sym_target)
  original_file_path = File.expand_path original_file
  sym_target_path    = File.expand_path sym_target.to_s

  if File.exists? original_file_path
    puts "Removing #{original_file_path}".yellow
    FileUtils.rm_rf original_file_path
  end

  puts "Symlinking #{original_file_path} -> #{sym_target_path}".green
  FileUtils.symlink sym_target_path, original_file_path
end

update_symlink '~/.vimrc', 'vim/vimrc'
update_symlink '~/.vim', 'vim'

update_symlink '~/.xmonad', 'xmonad'

update_symlink '~/.oh-my-zsh', 'zsh/oh-my-zsh'
update_symlink '~/.zshrc', 'zsh/.zshrc'

update_symlink '~/.xmobarrc', 'xmobar/.xmobarrc'

update_symlink '~/.gitconfig', 'git/.gitconfig'

update_symlink '~/.xresources', 'x/.xresources'
update_symlink '~/.xrdb', 'x/xrdb'
