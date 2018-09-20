# frozen_string_literal: true

module Smuggle
  module Importer
    class Base
      class << self
        attr_writer :attributes

        def inherited(subclass)
          subclass.attributes = []
        end

        def attributes(*names)
          @attributes.concat names
        end

        def attributes?
          @attributes.any?
        end

        def csv_converters
          Hash(header_converters: :symbol, converters: %i[all])
        end
      end

      attr_reader :row, :model

      def initialize(row, model)
        @model = model
        @row = row
      end

      def persist
        raise NotImplementedError
      end

      def to_h
        defined_attributes.each_with_object({}) do |attribute, hash|
          hash[attribute.to_sym] = respond_to?(attribute) ? public_send(attribute) : row[attribute.to_sym]
        end
      end

      def defined_attributes
        return self.class.attributes if self.class.attributes?

        return model.attribute_names if model.respond_to?(:attribute_names)

        []
      end
    end
  end
end
