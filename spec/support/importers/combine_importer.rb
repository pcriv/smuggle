# frozen_string_literal: true

module Importers
  class CombineImporter < BaseImporter
    attributes :name

    def name
      [row[:first_name], row[:last_name]].join(" ")
    end
  end
end
