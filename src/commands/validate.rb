module Validate
  extend self

  def register
    $parser.on("-r", "--register", "Validate tracked project files agree with system.") do |v|
      $options[:validate] = validate
    end
  end

  def validate
    $config.each do |config_unit, hash_object|
    end
  end
end

Validate.register
