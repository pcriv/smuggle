# frozen_string_literal: true

require "spec_helper"

RSpec.describe Smuggle::Importer::Base do
  subject(:importer) { importer_class.new(csv_row, User) }

  let(:csv_row) { CSV::Row.new(%i[name location], %w[Rick Earth]) }

  describe "#persist" do
    subject(:persist) { importer.persist }

    context "when the importer is empty" do
      let(:importer_class) { Importers::EmptyImporter }

      specify { expect { persist }.to raise_error(NotImplementedError) }
    end

    context "when the importer is basic" do
      let(:importer_class) { Importers::BasicUserImporter }

      specify { expect { persist }.not_to raise_error }
    end
  end

  describe "#to_h" do
    subject(:to_h) { importer.to_h }

    context "when the importer is empty" do
      let(:importer_class) { Importers::EmptyImporter }

      it { is_expected.to eq({}) }
    end

    context "when the importer is basic" do
      let(:importer_class) { Importers::BasicUserImporter }

      it "contains the specified attributes" do
        is_expected.to include(name: "Rick", location: "Earth")
      end

      context "and is given an extra column" do
        before { csv_row << { unnecessary_field: "Plumbus" } }

        it "does not contain any other keys" do
          expect(to_h.keys).to contain_exactly(:name, :location)
        end
      end
    end

    context "when the importer combines two fields" do
      let(:importer_class) { Importers::CombineImporter }
      let(:csv_row) { CSV::Row.new(%i[first_name last_name], %w[Rick Sanchez]) }

      it "contains the attribute combined from the CSV" do
        is_expected.to include(name: "Rick Sanchez")
      end
    end
  end
end
