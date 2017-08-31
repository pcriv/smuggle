# Smuggle


Is a gem to manage exports with ease, separating the logic from the models, resulting in a much cleaner codebase. Easy to use, with familiar structure.

**The Smuggler gem is not dependent on Rails**
You can use it on ActiveRecord models, as well as plain ruby objects and hashes.

## Installation


Add this line to your application's Gemfile:

```ruby
gem 'smuggle'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install smuggle
To generate an exporter, you can run the following command:
```
    $ rails g smuggle User
```

You can also include the attributes you wish to export by running:
```
    $ rails g smuggle User email username created_at
```
This will generate the following folder and files:
```
      create  app/exporters/application_exporter.rb
      create  app/exporters/user_exporter.rb
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
Smuggle::Services::Export.call(scope: User.all, exporter: UserExporter)
```
And that is all. You can assign it to a variable and then make it respond to `csv` to generate the desired file.
## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/pablocrivella/smuggle.

## Todo

- Implement `importer` functionality

## License


The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
