module Install
  extend self

  def register
    $parser.on("-i", "--install", "Install tracked files from project.") do |v|
      $options[:install] = install
    end
  end

  def install
    # $config.each do |config_unit, hash_object|
    #     if !hash_object["systems"].include?($system)
    #         puts "set: skipping #{config_unit}. Incompatible system."
    #         next
    #     end

    #     path = File.expand_path(hash_object["path"])
    #     project_path = "#{files_path}/" + path

    #     if File.exist?(path)
  end
end

Install.register
