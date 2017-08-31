module Smuggle
  class Base < SimpleDelegator
    class << self
      attr_accessor :attributes

      def inherited(base)
        base.attributes = []
      end

      def attributes(*names)
        @attributes.concat names
      end

      def attributes?
        @attributes.any?
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
