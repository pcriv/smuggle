# frozen_string_literal: true

require "spec_helper"

RSpec.describe Smuggle::Importer::Base do
  describe "#to_h" do
    let(:importer) { Importers::UserImporter.new(row, User) }
    let(:row) do
      CSV::Row.new(%i[first_name last_name location unnecessary_field], %w[Rick Sanchez Earth Plumbus])
    end

    it "converts csv row into an attributes hash" do
      expect(importer.to_h).to eq(Hash(name: "Rick Sanchez", location: "Earth"))
    end
  end
end
