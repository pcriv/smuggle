# Smuggle

[![Gem](https://img.shields.io/gem/v/smuggle.svg?style=flat)](http://rubygems.org/gems/smuggle)
[![Depfu](https://badges.depfu.com/badges/6f2f73672eae4d603d6ae923164435e2/overview.svg)](https://depfu.com/github/InspireNL/smuggle?project=Bundler)
[![Inline docs](http://inch-ci.org/github/InspireNL/smuggle.svg?branch=master&style=shields)](http://inch-ci.org/github/InspireNL/smuggle)
[![CircleCI](https://circleci.com/gh/InspireNL/smuggle.svg?style=svg)](https://circleci.com/gh/InspireNL/smuggle)
[![Maintainability](https://api.codeclimate.com/v1/badges/cc59cfca7a9d29c18e12/maintainability)](https://codeclimate.com/github/InspireNL/smuggle/maintainability)
[![Test Coverage](https://api.codeclimate.com/v1/badges/cc59cfca7a9d29c18e12/test_coverage)](https://codeclimate.com/github/InspireNL/smuggle/test_coverage)

Is a gem to manage exports and imports with ease, separating the logic from the models, resulting in a much cleaner codebase. Easy to use, with familiar structure.

**Smuggle is not dependent on Rails**, you can use it on ActiveModel/ActiveRecord models, as well as plain ruby objects and hashes.

Links:

  - [API Docs](https://www.rubydoc.info/gems/smuggle)
  - [Contributing](https://github.com/InspireNL/smuggle/blob/master/CONTRIBUTING.md)
  - [Code of Conduct](https://github.com/InspireNL/smuggle/blob/master/CODE_OF_CONDUCT.md)

## Requirements

1. [Ruby 2.5.0](https://www.ruby-lang.org)

## Installation

To install, run:

```
gem install smuggle
```

Or add the following to your Gemfile:

```
gem "smuggle"
```

## Usage

### Exporters

Given the following plain old ruby object:

```ruby
class User
  attr_accessor :name

  def initialize(name)
    @name = name
  end
end
```

An exporter can be defined by inheriting from [Smuggle::Exporter::Base](lib/smuggle/exporter/base.rb) and define the attributes to export:

```ruby
class UserExporter < Smuggle::Exporter::Base
  attributes :name
end
```

Extra logic can be establish inside the exporter file, using the same name as the attribute:

```ruby
class UserExporter < Smuggle::Exporter::Base
  attributes :name

  def name
    super + " - exported"
  end
end
```

If there are no attributes defined in the exporter and you are using ActiveModel or ActiveRecord, all the attributes of the record will be included.
If it is a hash, then all values will be included.

To generate the csv data simply call:

```ruby
users = [User.new("Rick Sanchez"), User.new("Morty Smith")]
Smuggle::Services::Export.call(scope: users, exporter: UserExporter)
# => "Full name,Full name\nRick Sanchez,Rick Sanchez\nMorty Smith,Morty Smith\n"
```

Or if you are using ActiveRecord, the exporter class will be automatically resolved from the scope:

```ruby
Smuggle::Services::Export.call(scope: User.all)
```

To add labels for your attributes (to show in the header instead of the raw attribute keys) you can add **attribute_labels** to your exporter:

``` ruby
class UserExporter < Smuggle::Exporter::Base
  attributes :name
  attribute_labels name: "Full name"
end

users = [User.new("Rick Sanchez"), User.new("Morty Smith")]

Smuggle::Services::Export.call(scope: users, exporter: UserExporter)
# => "Full name\nRick Sanchez\nMorty Smith\n"
```

### Importers

Give the following ActiveRecord model:

```ruby
class User < ApplicationRecord
  validates :full_name, :username, presence: true
end
```

To define a importers you need to inherit from [Smuggle::Importer::Base](lib/smuggle/importer/base.rb) and define the attributes to import:

```ruby
class UserImporter < Smuggle::Importer::Base
  # List all the attributes you need to import, everything else will be ignored
  attributes :full_name, :username

  # Computed attributes from the row data
  def full_name
    [row[:first_name], row[:last_name]].join(" ")
  end

  def persist
    # You can implement how to persist the data anyway you prefer
    # This is an example using active record
    model.create(to_h)
    # model.new(to_h).save(validate: false) # Another example skipping validations
  end
end
```

For example:

Given the following `users.csv` file:

```
"first_name","last_name","username"
"Rick","Sanchez","rsanchez"
"Morty","Smith","msmith"
"Jerry","Smith","jsmith"
```

Just run:

```ruby
Smuggle::Services::Import.call(model: User, filepath: "users.csv")
```

The importer class will be resolved from the model name, otherwise you could explicitely set the importer like this:

```ruby
Smuggle::Services::Import.call(model: User, filepath: "users.csv", importer: UserImporter)
```

### Generators

If you are using rails you can use the following generators:

```
$ rails g smuggle:install
create app/exporters/application_exporter.rb
create app/importers/application_importer.rb
```

To generate an exporter, you can run the following command:

```
$ rails g smuggle:exporter user
create app/exporters/user_exporter.rb
```

You can also include the attributes you wish to export by running:

```
$ rails g smuggle:exporter user email username created_at
create app/exporters/user_exporter.rb
```

And to generate an importer, just run:

```
$ rails g smuggle:importer user email username full_name
create app/importers/user_importer.rb
```

## Tests

To test, run:

```
bundle exec rspec spec/
```

## Versioning

Read [Semantic Versioning](https://semver.org) for details. Briefly, it means:

- Major (X.y.z) - Incremented for any backwards incompatible public API changes.
- Minor (x.Y.z) - Incremented for new, backwards compatible, public API enhancements/fixes.
- Patch (x.y.Z) - Incremented for small, backwards compatible, bug fixes.

## License

Copyright 2018 [Inspire Innovation BV](https://inspire.nl).
Read [LICENSE](LICENSE) for details.
