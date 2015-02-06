module PerconaMigrations
  module HelperMethods
    def percona_alter_table(*args)
      PerconaMigrations::Runners.run(*args)
    end
  end
end
