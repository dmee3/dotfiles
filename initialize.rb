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

def run_cmd(cmd, description = 'Running command...')
  puts "#{Colors.blue}#{description}#{Colors.default}"
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

#
# Bundle install
#
run_cmd('bundle install', 'Bundle installing...')

#
# Brew Dependencies
#
puts "#{Colors.blue}Brewing formulae...#{Colors.default}"
brew_list = `brew ls`
run_cmd_with_status('brew install fzf', 'Installing fzf...', '  ') unless brew_list =~ /fzf/
run_cmd_with_status('brew install highlight', 'Installing highlight...', '  ') unless brew_list =~ /highlight/

# Window manager
unless brew_list =~ /chunkwm/
  run_cmd_with_status('brew tap koekeishiya/formulae', 'Tapping chunkwm cask...', '  ')
  run_cmd_with_status('brew install chunkwm', 'Installing chunkwm...', '  ')
end
run_cmd_with_status(`brew install skhd`, 'Installing skhd...', '  ') unless brew_list =~ /skhd/

# Needed for pywal
run_cmd_with_status(`brew install python`, 'Installing Python 3 with pip3...', '  ') unless brew_list =~ /python/
run_cmd_with_status(`brew install imagemagick`, 'Installing imagemagick...', '  ') unless brew_list =~ /imagemagick/

#
# Pywal (custom color schemes by background)
#
pip_list = `pip3 list`
run_cmd_with_status(`pip3 install pywal`, "#{Colors.blue}Installing pywal...#{Colors.default}") unless pip_list ~/pywal/

#
# Config Curator
#
run_cmd('bundle exec curate -v', 'Curating...')

#
# Setup iTerm2 preferences
#
run_cmd('cp themes/com.googlecode.iterm2.plist ~/Library/Preferences/com.googlecode.iterm2.plist', 'Copying iTerm2 preferences...')
run_cmd('defaults read com.googlecode.iterm2', 'deleting iTerm2 cached settings...')

#
# Set source
#
run_cmd('source ~/.bash_profile', 'Sourcing new profile...')

puts "#{Colors.green}Done!  Please quit and restart iTerm2 for new settings to take effect.#{Colors.default}"

