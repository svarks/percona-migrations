require 'spec_helper'

RSpec.describe PerconaMigrations::Runners::Sql do
  let(:conn) { double() }
  let(:runner) do
    described_class.new('users', [
      'add column first_name string(255)',
      'add column last_name string(255)',
    ])
  end

  before do
    allow(ActiveRecord::Base).to receive(:connection).and_return(conn)
  end

  describe '#run' do
    it 'runs sql commands throuth ActiveRecord' do
      expect(conn).to receive(:execute).with('ALTER TABLE users add column first_name string(255)')
      expect(conn).to receive(:execute).with('ALTER TABLE users add column last_name string(255)')

      runner.run
    end
  end
end
