# frozen_string_literal: true

require "spec_helper"

RSpec.describe Smuggle::Importer::Base do
  subject(:importer) { importer_class.new(csv_row, imported_class) }

  let(:imported_class) { User }
  let(:csv_row) { CSV::Row.new(%i[name location], %w[Rick Earth]) }

  describe "#persist" do
    subject(:persist) { importer.persist }

    context "when the importer is empty" do
      let(:importer_class) { Importers::EmptyImporter }

      it { expect { persist }.to raise_error(NotImplementedError) }
    end

    context "when the importer is basic" do
      let(:importer_class) { Importers::BasicUserImporter }

      it { expect { persist }.not_to raise_error }
    end
  end

  describe "#to_h" do
    subject(:to_h) { importer.to_h }

    context "when the importer is empty and the model's class responds to .attribute_names" do
      let(:importer_class) { Importers::EmptyImporter }

      it "contains the specified attributes" do
        expect(to_h).to include(name: "Rick", location: "Earth")
      end
    end

    context "when the importer is empty and the model's class does not respond to .attribute_names" do
      let(:importer_class) { Importers::EmptyImporter }
      let(:imported_class) { Object }

      it { expect(to_h).to eq({}) }
    end

    context "when the importer is basic" do
      let(:importer_class) { Importers::BasicUserImporter }

      it "contains the specified attributes" do
        expect(to_h).to include(name: "Rick", location: "Earth")
      end
    end

    context "when the importer is basic and is given an extra column" do
      let(:importer_class) { Importers::BasicUserImporter }

      before { csv_row << {unnecessary_field: "Plumbus"} }

      it "does not contain any other keys" do
        expect(to_h.keys).to contain_exactly(:name, :location)
      end
    end

    context "when the importer combines two fields" do
      let(:importer_class) { Importers::CombineImporter }
      let(:csv_row) { CSV::Row.new(%i[first_name last_name], %w[Rick Sanchez]) }

      it "contains the attribute combined from the CSV" do
        expect(to_h).to include(name: "Rick Sanchez")
      end
    end
  end
end
