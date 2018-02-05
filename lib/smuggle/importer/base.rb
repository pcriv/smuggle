module Smuggle
  module Importer
    class Base
      class << self
        attr_writer :attributes

        def inherited(base)
          base.attributes = []
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
        self.class.attributes.each_with_object({}) do |attribute, hash|
          hash[attribute] = respond_to?(attribute) ? public_send(attribute) : row[attribute]
        end
      end
    end
  end
end
