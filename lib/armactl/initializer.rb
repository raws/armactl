require 'fileutils'
require 'pathname'

module ArmaCtl
  class Initializer
    def initialize(root_path)
      root_path = File.expand_path(normalize_root_path(root_path))
      @root_directory = Pathname.new(root_path)
    end

    def run
      create_root_directory
      copy_config
    end

    private

    attr_reader :root_directory

    def copy_config
      config = share_directory.join('config.example.yml')
      FileUtils.cp config.to_s, root_directory.join('config.yml').to_s
    end

    def create_root_directory
      root_directory.mkpath
    end

    def normalize_root_path(root_path)
      root_path.gsub(/\.armactl\z/i, '') + '.armactl'
    end

    def share_directory
      Pathname.new File.join(File.dirname(__FILE__), '../../share/armactl')
    end
  end
end
