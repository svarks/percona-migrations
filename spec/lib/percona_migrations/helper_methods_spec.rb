require 'spec_helper'

RSpec.describe PerconaMigrations::HelperMethods do
  subject do
    klass = Class.new do
      include PerconaMigrations::HelperMethods
    end
    klass.new
  end

  describe '#alter_table' do
    it 'calls a method on PerconaMigrations' do
      expect(PerconaMigrations::Runners).to receive(:run).with('users', ['add column name string(255)'])

      subject.percona_alter_table('users', ['add column name string(255)'])
    end
  end
end
