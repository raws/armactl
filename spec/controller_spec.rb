require 'spec_helper'
require 'yaml'

describe ArmaCtl::Controller do
  describe '#config' do
    subject { armactl.config }

    context 'when a valid config file exists' do
      let(:armactl) do
        within_armactl_directory { described_class.new }
      end

      it 'loads the expected config' do
        FakeFS.deactivate!
        expected_config_path = File.join(File.dirname(__FILE__),
          '../share/armactl/config.example.yml')
        expected_config = YAML.load_file(expected_config_path)
        FakeFS.activate!

        expect(subject).to eq(expected_config)
      end
    end

    context 'when a valid config file does not exist' do
      let(:armactl) do
        within_armactl_directory do
          FileUtils.rm 'config.yml'
          described_class.new
        end
      end

      it 'raises an error' do
        expect { subject }.to raise_error(RuntimeError,
          'Missing config: /example.armactl/config.yml')
      end
    end
  end

  describe '#root' do
    subject { armactl.root }

    let(:armactl) { described_class.new }

    shared_examples 'raises an error' do
      it 'raises an error' do
        expect { subject }.to raise_error(RuntimeError,
          'Must be inside a valid .armactl directory or set ARMACTL_ROOT')
      end
    end

    context 'when a root path is passed as an argument' do
      context 'and is a valid root directory' do
        let(:armactl) { described_class.new('/foo/../arg-direct.armactl') }
        before { FileUtils.mkdir('/arg-direct.armactl') }

        it { is_expected.to eq(Pathname.new('/arg-direct.armactl')) }
      end

      context 'and is inside a valid root directory' do
        let(:armactl) { described_class.new('/arg-nested.armactl/deeply/nested') }
        before { FileUtils.mkdir_p('/arg-nested.armactl/deeply/nested') }

        it { is_expected.to eq(Pathname.new('/arg-nested.armactl')) }
      end

      context 'and is an invalid root directory' do
        let(:armactl) { described_class.new('/foo') }
        before { FileUtils.mkdir('/foo') }
        include_examples 'raises an error'
      end
    end

    context 'when ARMACTL_ROOT is set' do
      before { ENV['ARMACTL_ROOT'] = '/foo/../env.armactl' }
      after { ENV.delete('ARMACTL_ROOT') }

      it { is_expected.to eq(Pathname.new('/env.armactl')) }
    end

    context 'when directly inside a valid root directory' do
      before do
        within_armactl_directory('/direct.armactl') { subject }
      end

      it { is_expected.to eq(Pathname.new('/direct.armactl')) }
    end

    context 'when deep inside a valid root directory' do
      before do
        FileUtils.mkdir_p '/nested.armactl/deeply/nested'
        Dir.chdir('/nested.armactl/deeply/nested') { subject }
      end

      it { is_expected.to eq(Pathname.new('/nested.armactl')) }
    end

    context 'when no valid root directory is present' do
      include_examples 'raises an error'
    end
  end

  describe '#server_version' do
    subject { described_class.new.server_version }

    before do
      within_armactl_directory { subject }
    end

    it { is_expected.to eq('1.76.143187') }
  end
end
