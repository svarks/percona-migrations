require 'spec_helper'

RSpec.describe PerconaMigrations do
  describe '::allow_sql?' do
    it 'is true by default' do
      expect(subject.allow_sql?).to eq(true)
    end

    it 'can be set to false' do
      subject.allow_sql = false

      expect(subject.allow_sql?).to eq(false)

      subject.allow_sql = true
    end
  end

  describe '::database_config' do
    it 'throws an exception if not set' do
      expect { subject.database_config }.to raise_exception
    end

    it 'returns config' do
      config = { 'username' => 'test' }
      subject.database_config = config

      expect(subject.database_config).to eq(config)

      subject.database_config = nil
    end
  end
end
