module Load
  extend self

  def register
    $parser.on("-l", "--load", "Load tracked files into project.") do |v|
      $options[:load] = load
    end
  end

  def load
    $config.flat_keys do |config_unit, hash_object|
      if !hash_object["systems"].include?($system)
        puts "load: skipping #{config_unit}. Incompatible system."
        next
      end

      if !hash_object["path"]
        puts "load: skipping #{config_unit}. Group has no path."
        next
      end

      path_str = hash_object["path"]
      path_str = File.expand_path(path_str)
      path = Pathname.new(path_str)

      project_path_str = get_project_path(hash_object)
      project_path = Pathname.new(project_path_str)
      if !File.exist?(project_path.parent)
        FileUtils.mkdir_p(project_path.parent)
      end

      if File.exist?(path)
        link_from_path(hash_object)
        puts "load: linking #{config_unit}."
      else
        puts "load: skipping #{config_unit}. Path does not exist."
      end
    end
  end
end

Load.register
