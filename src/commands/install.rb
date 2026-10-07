module Install
  extend self

  def register
    $parser.on("-i", "--install", "Install tracked files from project.") do |v|
      $options[:install] = install
    end
  end

  def install
    $config.each do |setting, setting_dictionary|
      if !on_system?(setting_dictionary)
        puts "install: skipping #{setting}. Incompatible system."
        next
      end

      path_str = File.expand_path(setting_dictionary["path"])
      project_path_str = get_project_path(setting_dictionary)

      path = Pathname.new(path_str)
      project_path = Pathname.new(project_path_str)

      if !File.exist?(project_path)
        puts "install: project file does not exist."
      end

      if !File.exist?(path.parent)
        FileUtils.mkdir_p(path.parent)
      end

      if !File.identical?(project_path, path)
        FileUtils.cp(project_path, path, verbose: true)
      end

      link_from_project(setting_dictionary)
      p "install: #{setting} set"
    end
  end
end

Install.register
