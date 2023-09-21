# frozen_string_literal: true

module Smuggle
  module Generators
    class ImporterGenerator < Rails::Generators::NamedBase
      source_root File.expand_path(File.join(File.dirname(__FILE__), "templates"))

      argument :attributes, type: :array, required: true

      def create_importer
        template "importer.rb.erb", File.join("app/importers", class_path, "#{file_name}_importer.rb")
      end
    end
  end
end
