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
    end

    def to_csv
      self.class.attributes.map do |name|
        __getobj__.respond_to?(name) ? public_send(name) : [name]
      end
    end
  end
end
