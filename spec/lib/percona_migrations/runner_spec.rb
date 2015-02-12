require 'spec_helper'

RSpec.describe PerconaMigrations::Runners do
  describe '::run' do
    before do
      expect(subject).to receive(:find_runner).and_return(runner_class)
    end

    context 'when runner is found' do
      let(:runner_class) { PerconaMigrations::Runners::Percona }
      let(:arguments) { [:arg1, :arg2, :arg3] }

      it 'runs the runner' do
        runner = double()
        expect(runner_class).to receive(:new).with(*arguments).and_return(runner)
        expect(runner).to receive(:run)

        subject.run(*arguments)
      end
    end

    context 'when runner is not found' do
      let(:runner_class) { nil }

      it 'throws an exception' do
        expect { subject.run }.to raise_exception
      end
    end
  end

  describe '::find_runner' do
    before do
      expect(PerconaMigrations::Runners::Percona).to receive(:available?).and_return(percona_available)
    end

    context 'when percona is available' do
      let(:percona_available) { true }

      it 'returns percona runner if enabled' do
        expect(subject.find_runner).to eq(PerconaMigrations::Runners::Percona)
      end
    end

    context 'when percona is not available' do
      let(:percona_available) { false }

      context 'and sql is enabled' do
        it 'returns sql runner' do
          expect(subject.find_runner).to eq(PerconaMigrations::Runners::Sql)
        end
      end

      context 'and sql is disabled' do
        before do
          allow(PerconaMigrations).to receive(:allow_sql?).and_return(false)
        end
        it 'returns nil' do
          expect(subject.find_runner).to eq(nil)
        end
      end
    end
  end
end
