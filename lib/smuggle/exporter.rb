require 'csv'

module Smuggle
  class Exporter
    class << self
      def call(scope:, **options)
        new(scope, options).send(:call)
      end
    end

    private

    attr_reader :scope

    def initialize(scope, options = {})
      @scope = scope
      @exporter = options[:exporter]
    end

    def call
      generate_csv
    end

    def resolve
      "#{scope.name.demodulize.pluralize}Exporter".constantize
    rescue
      raise ExporterNotFound
    end

    def exporter
      @exporter || resolve
    end

    def generate_csv
      CSV.generate do |csv|
        csv << exporter.attributes

        scope.each do |record|
          csv << exporter.new(record).to_csv
        end
      end
    end
  end
end
