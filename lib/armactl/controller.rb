require 'pathname'
require 'yaml'

module ArmaCtl
  class Controller
    attr_reader :root

    def initialize(root_dir = nil)
      load_root root_dir
    end

    def config
      @config ||= load_config
    end

    def server_version
      # TODO
    end

    private

    def find_app_root_from(working_dir)
      dir = Pathname.new(working_dir)
      dir = dir.parent while dir != dir.parent && dir.basename.to_s !~ /\.armactl\z/i
      dir == dir.parent ? no_root! : dir
    end

    def load_config
      config_path = root.join('config.yml')

      if config_path.readable?
        YAML.load_file config_path.to_s
      else
        raise "Missing config: #{config_path}"
      end
    end

    def load_root(root_dir)
      @root = if root_dir
        find_app_root_from File.expand_path(root_dir)
      elsif ENV['ARMACTL_ROOT']
        Pathname.new File.expand_path(ENV['ARMACTL_ROOT'])
      else
        find_app_root_from Dir.pwd
      end
    end

    def no_root!
      raise 'Must be inside a valid .armactl directory or set ARMACTL_ROOT'
    end
  end
end
