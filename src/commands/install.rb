module Install
  extend self

  def register
    $parser.on("-i", "--install", "Install tracked files from project.") do |v|
      $options[:install] = install
    end
  end

  def install_file(setting, setting_dictionary)
    if !setting_dictionary["path"]
      puts "install: skipping #{setting}. Group has no path."
      return
    end

    path_prefix = Pathname.new("files/#{setting}")
    project_path = path_prefix / setting_dictionary["project_path"]
    path = Pathname.new(setting_dictionary["path"])

    if !File.exist?(project_path)
      puts "install: project file does not exist."
    end

    if !File.exist?(path.parent)
      FileUtils.mkdir_p(path.parent)
    end

    if !File.identical?(project_path, path)
      FileUtils.cp(project_path, path, verbose: true)
    end

    link_from_project(project_path, path)
    puts "install: #{setting} set"
  end

  def install
    $config.each do |setting, setting_dictionary|
      if !on_system?(setting_dictionary)
        puts "install: skipping #{setting}. Incompatible system."
        next
      end

      setting_dictionary.fetch("files", []).each do |file_dict|
        install_file(setting, file_dict)
      end

      setting_dictionary.fetch("path", []).each do |command_dict|
        p command_dict
      end

      next
    end
  end
end

Install.register
