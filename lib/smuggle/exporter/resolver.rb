# frozen_string_literal: true

module Smuggle
  module Exporter
    class Resolver
      def call(scope:)
        Object.const_get("#{scope.name}Exporter")
      rescue NameError
        raise ExporterNotFound
      end
    end
  end
end
