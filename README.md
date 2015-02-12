# Percona Migrations

Allows to use `pt-online-schema-change` for table changes in MySQL.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'percona-migrations'
```

Create `config/initializers/percona_migrations.rb` with:

```ruby
PerconaMigrations.database_config = ActiveRecord::Base.configurations[Rails.env]
PerconaMigrations.allow_sql = !Rails.env.production?

ActiveRecord::Migration.send :include, PerconaMigrations::HelperMethods
```

## Usage

```ruby
class AddAddressToUsers < ActiveRecord::Migration
  def up
    commands = columns.map { |name, type| "ADD COLUMN #{name} #{type}" }

    percona_alter_table :users, commands
  end

  def down
    commands = columns.map { |name, _| "DROP COLUMN #{name}" }

    percona_alter_table :users, commands
  end

  private

  def columns
    { street: 'STRING(255)' },
    { city:   'STRING(255)' },
    { state:  'STRING(2)' },
    { zip:    'STRING(10)' }
  end
end
```

## Contributing

1. Fork it ( https://github.com/[my-github-username]/percona-migrations/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
