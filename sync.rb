require 'fileutils'
require 'colored'

def ensure_directory(dependency)
  dependency_path = File.expand_path dependency 
  unless File.exists? dependency_path
    puts "Making #{dependency_path}".green
    Dir.mkdir dependency_path
  end
end

def update_symlink(original_file, sym_target)
  original_file_path = File.expand_path original_file
  sym_target_path = sym_target.to_s

  puts "Removing #{original_file_path}".yellow
  FileUtils.rm_rf original_file_path

  puts "Symlinking #{original_file_path} -> #{target_path}".green
  File.symlink sym_target_path, original_file_path
end


def vim
  update_symlink '~/.vimrc', 'vim/vimrc'

  ensure_directory '~/.vim'
  update_symlink '~/.vim/', 'vim'
end
