DEV_DIR = '/Users/dmeehan/Stuff/CMM/dev'.freeze

module Colors
  RED = "\e[31m".freeze
  GREEN = "\e[32m".freeze
  YELLOW = "\e[33m".freeze
  DEFAULT = "\e[0m".freeze
end

class OverrideList
  def initialize(container_name)
    @container_name = container_name
  end

  def print
    str = list.join("\n")
    return str if list.include?(@container_name)

    str << "\n\n#{Colors::RED}WARNING: #{@container_name} is not in local overrides!"
  end

  def list
    path = "#{DEV_DIR}/local_override.yaml"
    return [] unless File.file?(path)

    # List format
    #
    # local_development:
    #   cmm_php
    #   eulas
    #   account
    @override_list ||= File.open(path) do |f|
      f.readlines
       .drop_while { |l| l.strip != 'local_development:' }
       .drop(1)
       .map(&:strip)
    end
  end
end

class Metadata
  def initialize(container_name, ancestors, enabled)
    @container_name = container_name
    @ancestors = ancestors
    @enabled = enabled
  end

  def print_dependencies
    color = @enabled ? Colors::GREEN : Colors::RED
    str = "#{'| ' * @ancestors.length}- #{color}#{@container_name}#{Colors::DEFAULT}\n"
    return str unless @enabled

    dependencies.each { |dep| str << dep.print_dependencies }
    str
  end

  def dependencies
    @dependencies ||= [].tap do |deps|
      role_list.each do |role|
        dep_name = role.match(/.*(\b\w+)$/).captures[0]

        # Avoid infinite recursion by skipping dependencies already in the tree
        unless @ancestors.include?(dep_name)
          deps << Metadata.new(dep_name, @ancestors + [@container_name], role[0] != '#')
        end
      end
    end
  end

  private

  def role_list
    path = "#{DEV_DIR}/roles/#{@container_name}/meta/main.yml"
    return [] unless File.file?(path)

    # List format (disabled entries will be commented out)
    #
    # dependencies:
    #   - role: <app>
    #   - role: <app>
    @role_list ||= File.open(path) do |f|
      f.readlines
       .drop_while { |l| l.strip != 'dependencies:' }
       .drop(1)
       .map(&:strip)
       .take_while { |l| l =~ /- role: / }
    end
  end
end

exit(1) unless ARGV.length == 1
meta = Metadata.new(ARGV[0], [], true)
overrides = OverrideList.new(ARGV[0])
puts "#{Colors::YELLOW}LOCAL APPS#{Colors::DEFAULT}\n#{overrides.print}\n\n"
puts "#{Colors::YELLOW}DEPENDENCIES#{Colors::DEFAULT}\n#{meta.print_dependencies}\n"
