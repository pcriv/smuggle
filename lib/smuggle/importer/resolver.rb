# frozen_string_literal: true

module Smuggle
  module Importer
    class Resolver
      def call(model:)
        Object.const_get("#{model.name}Importer")
      rescue NameError
        raise ImporterNotFound
      end
    end
  end
end
