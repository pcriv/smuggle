# frozen_string_literal: true

module Smuggle
  module Exporter
    class Base < SimpleDelegator
      class << self
        attr_writer :attributes
        attr_writer :attribute_labels

        def inherited(base)
          base.attributes = []
          base.attribute_labels = {}
        end

        def attributes(*names)
          @attributes.concat names
        end

        def attributes?
          @attributes.any?
        end

        def attribute_labels(labels)
          @attribute_labels.merge!(labels)
        end

        def attribute_labels?
          @attribute_labels.any?
        end

        def header
          return @attributes unless attribute_labels?

          @attributes.map do |attribute|
            @attribute_labels.fetch(attribute, attribute)
          end
        end
      end

      def to_csv
        defined_attributes.map do |name|
          respond_to?(name) ? public_send(name) : __getobj__[name]
        end
      end

      def defined_attributes
        return self.class.attributes if self.class.attributes?
        return attribute_names if __getobj__.respond_to?(:attribute_names)

        keys if __getobj__.respond_to?(:keys)
      end
    end
  end
end
