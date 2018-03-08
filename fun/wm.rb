def service_started?(service, list)
  matches = list.split("\n").select { |s| s =~ /#{service}\s+started/ }
  matches.count > 0
end

list = `brew services list`

if service_started?('chunkwm', list) || service_started?('skhd', list)
  puts 'Starting chunkwm...'
  `brew services stop chunkwm`
  puts 'Starting skhd...'
  `brew services stop skhd`
else
  puts 'Stopping chunkwm...'
  `brew services start chunkwm`
  puts 'Stopping skhd...'
  `brew services start skhd`
end
