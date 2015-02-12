require 'spec_helper'

RSpec.describe PerconaMigrations::Runners::Percona do
  subject { described_class }

  let(:percona_command) { '/bin/pt-online-schema-change' }

  describe '::percona_command' do
    it 'is looking for pt-online-schema-change in $PATH' do
      expect(subject).to receive(:`).with('which pt-online-schema-change').and_return(percona_command + "\n")
      expect(subject.percona_command).to eq(percona_command)
    end
  end

  describe '::available?' do
    it 'returns true when percona_command is present' do
      expect(subject).to receive(:percona_command).and_return('/bin/percona')
      expect(subject.available?).to eq(true)
    end
  end

  describe '#run' do
    let(:db_config) do
      {
        'host'     => 'localhost',
        'port'     => '3306',
        'username' => 'root',
        'password' => 'test',
        'database' => 'test-db'
      }
    end
    let(:runner) { described_class.new('users', ['add column name string(255)']) }
    let(:arguments) do
      [
        "--alter 'add column name string(255)'",
        "-h localhost",
        "-P 3306",
        "-u root",
        "D=test-db,t=users",
        "-p $PASSWORD"
      ]
    end

    before do
      allow(PerconaMigrations).to receive(:database_config).and_return(db_config)
      allow(subject).to receive(:percona_command).and_return(percona_command)
    end

    it 'runs percona command 2 times (dry-run and execute)' do
      command = "#{percona_command} #{arguments.join(' ')}"

      expect(runner).to receive(:system).
        with({ 'PASSWORD' => 'test' }, "#{command} --dry-run").
        and_return(true)

      expect(runner).to receive(:system).
        with({ 'PASSWORD' => 'test' }, "#{command} --execute").
        and_return(true)

      runner.run
    end

    it 'throws an exception if dry-run fails' do
      expect(runner).to receive(:system).
        with({ 'PASSWORD' => 'test' }, "#{percona_command} #{arguments.join(' ')} --dry-run").
        and_return(false)

      expect { runner.run }.to raise_exception
    end
  end
end
