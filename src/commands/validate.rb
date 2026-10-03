require_relative "../utils"

module Validate
  extend self

  def register
    $parser.on("-v", "--validate", "Validate tracked project files agree with system.") do |v|
      $options[:validate] = validate
    end
  end

  def validate
  end
end

Validate.register
