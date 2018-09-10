# frozen_string_literal: true

module Smuggle
  module Services
    class Import
      class << self
        def call(model:, filepath:, **options)
          new(model, filepath, options).send(:call)
        end
      end

      private

      attr_reader :model, :filepath

      def initialize(model, filepath, options = {})
        @filepath = filepath
        @importer = options[:importer]
        @model = model
      end

      def call
        import_from_csv
      end

      def resolve
        Object.const_get("#{model.name}Importer")
      rescue NameError
        raise ImporterNotFound
      end

      def importer
        @importer || resolve
      end

      def import_from_csv
        CSV.read(filepath, headers: true, **importer.csv_converters).map do |row|
          importer.new(row, model).persist
        end
      end
    end
  end
end
