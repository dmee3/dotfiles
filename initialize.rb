module Colors
  TEXT_COLORS = {
    red: "\e[31m",
    green: "\e[32m",
    yellow: "\e[33m",
    blue: "\e[34m",
    magenta: "\e[35m",
    cyan: "\e[36m",
    white: "\e[37m",
    default: "\e[39m"
  }.freeze

  TEXT_COLORS.each { |k, v| define_singleton_method(k) { v } }
end

def run_cmd(cmd, description = 'Running command...', indent = '')
  puts description
  `#{cmd}`
end

def run_cmd_with_status(cmd, description = 'Running command...', indent = '')
  puts description
  if `#{cmd}` == 0
    puts "#{indent}#{Colors.green}Done!#{Colors.default}"
    true
  else
    puts "#{indent}#{Colors.red}Error occurred.  Try running `#{cmd}`#{Colors.default}"
    false
  end
end

# Bundle install
run_cmd('bundle install', "#{Colors.blue}Bundle installing...#{Colors.default}")

# Brew Dependencies
puts "#{Colors.blue}Brewing formulae...#{Colors.default}"
brew_list = `brew ls`
run_cmd_with_status('brew install fzf', 'Installing fzf...', '  ') unless brew_list =~ /fzf/
unless brew_list =~ /chunkwm/
  run_cmd_with_status('brew tap crisidev/homebrew-chunkwm', 'Tapping chunkwm cask...', '  ')
  run_cmd_with_status('brew install chunkwm', 'Installing chunkwm...', '  ')
end
run_cmd_with_status(`brew install skhd`, 'Installing skhd...', '  ') unless brew_list =~ /skhd/

# Config Curator
run_cmd('bundle exec config_curator', "#{Colors.blue}Curating...#{Colors.default}")
