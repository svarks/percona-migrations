module PerconaMigrations
  module Runners
    class Sql < Base
      def run
        @commands.each do |command|
          run_command command
        end
      end

      private

      def run_command(command)
        sql = "ALTER TABLE #{@table_name} #{command}"

        log "Running SQL: \"#{sql}\""

        conn.execute sql
      end

      def conn
        @conn ||= ActiveRecord::Base.connection
      end
    end
  end
end
