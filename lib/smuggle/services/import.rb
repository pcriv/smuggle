require 'csv'

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
        "#{model.name.demodulize}Importer".constantize
      rescue NameError
        raise ImporterNotFound
      end

      def importer
        @importer || resolve
      end

      def import_from_csv
        CSV.foreach(filepath, headers: true, **importer.csv_converters) do |row|
          importer.new(row, model).persist
        end
      end
    end
  end
end
