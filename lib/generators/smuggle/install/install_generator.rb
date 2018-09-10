# frozen_string_literal: true

module Smuggle
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path(File.join(File.dirname(__FILE__), "templates"))

      def copy_application_exporter
        template "application_exporter.rb", "app/exporters/application_exporter.rb"
      end

      def copy_application_importer
        template "application_importer.rb", "app/importers/application_importer.rb"
      end
    end
  end
end
