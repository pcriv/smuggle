# Smuggle

Is a gem to manage exports with ease, separating the logic from the models, resulting in a much cleaner codebase. Easy to use, with familiar structure.

**Smuggle is not dependent on Rails**, you can use it on ActiveRecord models, as well as plain ruby objects and hashes.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'smuggle'
```

And then execute:

```
$ bundle
```

Or install it yourself as:

```
$ gem install smuggle
```

To generate the base exporter run:

```
$ rails g smuggle:install
create app/exporters/application_exporter.rb
```

To geneate an exporter, you can run the following command:

```
$ rails g smuggle:exporter user
create app/exporters/user_exporter.rb
```

You can also include the attributes you wish to export by running:

```
$ rails g smuggle:exporter user email username created_at
create app/exporters/user_exporter.rb
```

## Example

Inside the `user_exporter.rb` file:

```ruby
class UserExporter < ApplicationExporter
  attributes :email, :username, :created_at
end
```

Extra logic can be establish inside the exporter file, using the same name as the attribute:

```ruby
class UserExporter < ApplicationExporter
  attributes :email, :username, :created_at

  def created_at
    super.created_at.strftime("%m/%d/%Y")
  end
end
```

If there are no attributes defined in the exporter, all the attributes of the ActiveModel record will be included.
If it is a hash, then all values will be included.

## Usage

Generate the csv in the desired export controller simply call:

```ruby
class User
  attr_accessor :name

  def initialize(name)
    @name = name
  end
end

class UserExporter < ApplicationExporter
  attributes :name
end

users = [User.new('Rick Sanchez'), User.new('Morty Smith')]

Smuggle::Services::Export.call(scope: users, exporter: UserExporter)
# => "name\n" + "Rick Sanchez\n" + "Morty Smith\n"
```

Or if you are using active record, the exporter class will be automatically resolved from the scope:

```ruby
Smuggle::Services::Export.call(scope: User.all)
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/InspireNL/smuggle.

## Todo

- Implement `importer` functionality

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
