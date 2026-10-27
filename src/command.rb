class Command
  class << self
    def self.register
      raise NoMethodError
    end

    def action
      raise NoMethodError
    end

    def run_action_from_project
      $config.each do |setting, config_types|
        if !config_types.include?("commands")
          next
        end

        action_path = Pathname.new($files_path) / setting
        p action_path
      end
    end
  end
end
