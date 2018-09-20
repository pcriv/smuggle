# frozen_string_literal: true

module Importers
  # A base importer that sets up simple storage of imported data when inherited from.
  class BaseImporter < Smuggle::Importer::Base
    class << self
      attr_accessor :db

      def inherited(subclass)
        super
        subclass.db = []
      end
    end

    def persist
      model.new(*to_h.values).tap do |record|
        self.class.db << record
      end
    end
  end
end
