require 'percona_migrations/runners/base'
require 'percona_migrations/runners/percona'
require 'percona_migrations/runners/sql'

module PerconaMigrations
  module Runners
    def self.run(*args)
      runner_class = find_runner

      unless runner_class
        raise "No available migration runners found."
      end

      runner = runner_class.new(*args)
      runner.run
    end

    def self.find_runner
      if Runners::Percona.available?
        Runners::Percona
      else
        log_percona_install_command
        Runners::Sql if PerconaMigrations.allow_sql?
      end
    end

    private

    def self.log_percona_install_command
      logger = PerconaMigrations.logger
      return unless logger

      logger.warn ""
      logger.warn "*" * 80
      logger.warn ""
      logger.warn "`#{Runners::Percona::COMMAND}` command not found, please install percona tools:"
      logger.warn "$ brew install percona-toolkit"
      logger.warn ""
      logger.warn "*" * 80
      logger.warn ""
    end
  end
end
