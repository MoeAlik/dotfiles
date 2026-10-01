require 'etc'
require 'pp'
require 'fileutils'
require 'optparse'
require "toml-rb"

$files_path = "files"

$options = {}
$system
$config

def setup_args
    OptionParser.new do |opts|
        opts.banner = <<~HEREDOC
        dotfiles manager

        HEREDOC

        opts.on("-l", "--load", "Load whitelisted files/dirs") do |v|
            $options[:load_action] = true
        end

        opts.on("-c", "--clean", "Clean up untagged files") do |v|
            $options[:clean_action] = true
        end
        
    end.parse!
end 

def get_toml_object
    toml_dumps = File.read("configs/config.toml")
    return TomlRB.parse(toml_dumps)
end

def link(path)
    # is there a ruby path abstraction?
    project_path = "#{$files_path}/#{File.basename(path)}"
    if File.exist?(project_path)
        FileUtils.remove_file(project_path)
    end
    File.link(path, project_path)
end

def load
    $config.each do |config_unit, hash_object|
        if !hash_object["systems"].include?($system)
            puts "load: skiping #{config_unit}. Incompatible system."
            next
        end

        path = File.expand_path(hash_object["path"])
        if File.exist?(path)
            link(path)
            puts "load: linking #{config_unit}."
        else
            puts "load: skipping #{config_unit}. Path does not exist."
        end
            
    end
end

def clean
    ignore_list = [".", "..", ".gitkeep"]
    tracked_files = $config
        .map {|k, v| File.basename(v["path"])}
    untracked_files = Dir.entries($files_path)
        .reject {|f| ignore_list.include?(f)}
        .reject{ |f| tracked_files.include?(f)}

    untracked_files.each do |f|
        p "removing untracked file #{f}"
        FileUtils.remove_file("#{$files_path}/#{f}")
    end
end

def handle_args
    if $options[:load_action]
        load
        return
    end

    if $options[:clean_action]
        clean
        return
    end

    raise "no action set"
end

def main
    $system = Etc.uname[:sysname]
    $config = get_toml_object
    setup_args
    handle_args
end

if __FILE__ == $0
    main()
end
