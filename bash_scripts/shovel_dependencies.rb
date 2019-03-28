ROLE_REGEX = /.*(\b\w+)$/
DEV_DIR = '/Users/dmeehan/Stuff/CMM/dev'

class MetaFile
  def initialize(app_name)
    @path = "#{DEV_DIR}/roles/#{app_name}/meta/main.yml"
  end

  def enabled_dependencies
    all_dependencies
      .reject { |l| l.strip[0] == '#' }
      .map { |d| d.match(/.*(\b\w+)$/).captures[0] }
  end

  def disabled_dependencies
    all_dependencies
      .select { |l| l.strip()[0] == '#' }
      .map { |d| d.match(/.*(\b\w+)$/).captures[0] }
  end

  def all_dependencies
    return @dependencies if @dependencies

    # Cut out everything before the 'dependencies:' line,
    # then cut that line, too, then take every line until
    # you find an empty line or the end of the file
    @dependencies ||= contents
      .drop_while { |l| l.strip != 'dependencies:' }
      .drop(1)
      .take_while { |l| !l.strip.empty? }
  end

  private

  def contents
    return @contents if @contents
    raise IOError.new('Meta file does not exist') unless File.file?(@path)
    File.open(@path) { |f| @contents = f.readlines }
  end
end

if ARGV.length == 1
  app_name = ARGV[0] 
else
  exit(1)
end

puts "\e[34mSHOVELING #{app_name.upcase}\e[0m\n\n"

begin
  meta = MetaFile.new(app_name)
  enabled = meta.enabled_dependencies
  disabled = meta.disabled_dependencies

  unless enabled.empty?
    puts "\e[32mENABLED DEPENDENCIES\e[0m"
    enabled.each { |d| puts " - #{d}" }
    puts "\n"
  end

  unless disabled.empty?
    puts "\e[31mDISABLED DEPENDENCIES\e[0m"
    disabled.each { |d| puts " - #{d}" }
    puts "\n"
  end
rescue IOError => e
  puts "\e[31mERROR GETTING APP INFO: #{e}\e[0m\n\n"
end

puts "\n"
