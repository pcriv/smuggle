# frozen_string_literal: true

module Importers
  class UserImporter < Smuggle::Importer::Base
    attributes :name, :location

    @db = []

    class << self
      attr_accessor :db
    end

    def name
      [row[:first_name], row[:last_name]].join(" ")
    end

    def persist
      model.new(*to_h.values).tap do |record|
        self.class.db << record
      end
    end
  end
end
