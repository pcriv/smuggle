# frozen_string_literal: true

module Smuggle
  module Generators
    class ExporterGenerator < Rails::Generators::NamedBase
      source_root File.expand_path(File.join(File.dirname(__FILE__), "templates"))

      argument :attributes, type: :array, required: false

      def create_exporter
        template "exporter.rb.erb", File.join("app/exporters", class_path, "#{file_name}_exporter.rb")
      end
    end
  end
end
