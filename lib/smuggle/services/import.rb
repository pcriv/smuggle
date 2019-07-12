# frozen_string_literal: true

module Smuggle
  module Services
    class Import
      def self.call(**args)
        new.call(args)
      end

      def initialize(resolver: Smuggle::Importer::Resolver.new)
        @resolver = resolver
      end

      def call(model:, filepath:, **options)
        importer = options.fetch(:importer) { @resolver.call(model: model) }

        CSV.read(filepath, headers: true, **importer.csv_converters).map do |row|
          importer.new(row, model).persist
        end
      end
    end
  end
end
