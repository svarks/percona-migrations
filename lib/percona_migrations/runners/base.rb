module PerconaMigrations
  module Runners
    class Base
      def self.available?
        true
      end

      def initialize(table_name, commands)
        @table_name = table_name
        @commands = commands
      end

      def run
        raise NotImplementerError
      end

      def log(msg)
        logger.info(msg) if logger
      end

      def logger
        PerconaMigrations.logger
      end
    end
  end
end
