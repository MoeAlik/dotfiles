module Load
  extend self

  def register
    $parser.on("-l", "--load", "Load tracked files into project.") do |v|
      $options[:load] = load
    end
  end

  def load_file(setting, setting_dictionary)

    p setting
    p setting_dictionary

    if !setting_dictionary["path"]
      puts "load: skipping #{setting}. Group has no path."
      return
    end

    path_prefix = Pathname.new("files/#{setting}")
    project_path = path_prefix / setting_dictionary["project_path"]
    path = Pathname.new(File.expand_path(setting_dictionary["path"]))

    if !File.exist?(project_path)
      puts "load: projcet file does not exist."
    end

    if !File.exist?(project_path.parent)
      FileUtils.mkdir_p(project_path.parent)
    end

    if File.exist?(path)
      link_from_path(path, project_path)
      puts "load: linking #{setting}."
    else
      puts "load: skipping #{setting}. Path does not exist."
    end
  end

  def load
    $config.each do |setting, setting_dictionary|
      if !on_system?(setting_dictionary)
        puts "load: skipping #{setting}. Incompaitble system."
        next
      end

      setting_dictionary.fetch("files", []).each do |file_dict|
        load_file(setting, file_dict)
      end

      setting_dictionary.fetch("path", []).each do |command_dict|
        p command_dict
      end
    end
  end
end

Load.register
