require 'spec_helper'

describe ArmaCtl::Initializer do
  describe '#run' do
    include FakeFS::SpecHelpers

    shared_examples 'initializes an armactl config' do
      it 'creates the root dir' do
        expect(root).to be_directory
      end

      it 'copies the example config' do
        config = root.join('config.yml')
        expected_content = File.read(File.join(File.dirname(__FILE__),
          '../share/armactl/config.example.yml'))

        expect(config).to be_readable
        expect(config.read).to eq(expected_content)
      end
    end

    let(:root) { Pathname.new('/example.armactl') }

    before do
      FakeFS::FileSystem.clone File.join(File.dirname(__FILE__), '../share/armactl')
      described_class.new(input_path).run
    end

    context 'when the input path has no extension' do
      let(:input_path) { '/example' }
      include_examples 'initializes an armactl config'
    end

    context 'when the input path ends in lowercase .armactl' do
      let(:input_path) { '/example.armactl' }
      include_examples 'initializes an armactl config'
    end

    context 'when the input path ends in oddly-cased .ArmACtl' do
      let(:input_path) { '/example.ArmACtl' }
      include_examples 'initializes an armactl config'
    end
  end
end
