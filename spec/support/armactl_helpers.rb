module ArmaCtl
  module SpecHelpers
    def self.included(mod)
      mod.include FakeFS::SpecHelpers
    end

    def within_armactl_directory(root_directory_path = '/example.armactl', &block)
      create_valid_root_directory root_directory_path
      Dir.chdir root_directory_path, &block
    end

    private

    def clone_share_directory
      FakeFS::FileSystem.clone File.join(File.dirname(__FILE__), '../../share/armactl')
    end

    def create_valid_root_directory(root_directory_path)
      clone_share_directory
      ArmaCtl::Initializer.new(root_directory_path).run
    end
  end
end
