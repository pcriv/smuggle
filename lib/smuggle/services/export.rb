# frozen_string_literal: true

module Smuggle
  module Services
    class Export
      def self.call(args)
        new.call(**args)
      end

      def initialize(resolver: Smuggle::Exporter::Resolver.new)
        @resolver = resolver
      end

      def call(scope:, exporter: @resolver.call(scope: scope))
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
