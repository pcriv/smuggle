# frozen_string_literal: true

module Smuggle
  module Services
    class Export
      class << self
        def call(scope:, **options)
          new(scope, options).send(:call)
        end
      end

      private

      attr_reader :scope

      def initialize(scope, options = {})
        @exporter = options[:exporter]
        @scope = scope
      end

      def call
        generate_csv
      end

      def resolve
        Object.const_get("#{scope.name}Exporter")
      rescue NameError
        raise ExporterNotFound
      end

      def exporter
        @exporter || resolve
      end

      def generate_csv
        CSV.generate do |csv|
          csv << exporter.header

          method = :each
          method = :find_each if scope.respond_to?(:find_each)

          scope.public_send(method) do |record|
            csv << exporter.new(record).to_csv
          end
        end
      end
    end
  end
end
