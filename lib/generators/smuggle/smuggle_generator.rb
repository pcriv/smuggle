module Smuggle
  module Generators
    class SmuggleGenerator < Rails::Generators::Base
      namespace 'smuggle'

      source_root File.expand_path('../../templates', __FILE__)

      desc 'Generates an Exporter with the given NAME.' \
           'Additionally, you can pass the attributes you want to include in the export'

      argument :scope, required: true,
        desc: 'The scope to create exporter for, e.g. users, comments'

      argument :attributes, type: :array, required: false,
        desc: 'Specify the attributes you want to export, these will also be the headers.'

      def create_exporter
        template 'exporter.rb', "app/exporters/#{scope.underscore}_exporter.rb"
      end
    end
  end
end
