module Importers
  class UserImporter < Smuggle::Importer::Base
    attributes :name, :location

    @db = []

    class << self
      attr_accessor :db
    end

    def name
      [row[:first_name], row[:last_name]].join(' ')
    end

    def persist
      self.class.db << model.new(to_h[:name], to_h[:location])
    end
  end
end
