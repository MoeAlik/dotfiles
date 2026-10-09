module Load
  extend self

  def register
    $parser.on("-l", "--load", "Load tracked files into project.") do |v|
      $options[:load] = load
    end
  end

  def load
    $config.each do |config_unit, hash_object|
      if !hash_object["systems"].include?($system)
        puts "load: skipping #{config_unit}. Incompatible system."
        next
      end

      if !hash_object["path"]
        puts "load: skipping #{config_unit}. Group has no path"
      end

      path = File.expand_path(hash_object["path"])
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
