# frozen_string_literal: true

require "spec_helper"

RSpec.describe Smuggle::Importer::Base do
  subject(:importer) { importer_class.new(row, User) }

  context "when the importer is empty" do
    let(:importer_class) { Importers::EmptyImporter }
    let(:row) { CSV::Row.new(%i[name location], %w[Rick Earth]) }

    describe "#persist" do
      subject(:persist) { importer.persist }

      it { expect { persist }.to raise_error(NotImplementedError) }
    end

    describe "#to_h" do
      subject(:to_h) { importer.to_h }

      it { is_expected.to eq({}) }
    end

    describe "#defined_attributes" do
      subject(:defined_attributes) { importer.defined_attributes }

      it { is_expected.to eq([]) }
    end
  end

  context "when the importer is basic" do
    let(:importer_class) { Importers::BasicUserImporter }
    let(:row) { CSV::Row.new(%i[name location unnecessary_field], %w[Rick Earth Plumbus]) }

    describe "#persist" do
      subject(:persist) { importer.persist }

      it "does not raise an exception" do
        expect { persist }.not_to raise_error
      end
    end

    describe "#to_h" do
      subject(:to_h) { importer.to_h }

      it "contains the requested attributes" do
        expect(to_h).to include(name: "Rick", location: "Earth")
      end

      it "does not contain other keys" do
        expect(to_h.keys).to contain_exactly(:name, :location)
      end
    end
  end

  context "when the importer combines two fields" do
    let(:importer_class) { Importers::CombineImporter }
    let(:row) { CSV::Row.new(%i[first_name last_name], %w[Rick Sanchez]) }

    describe "#to_h" do
      subject(:to_h) { importer.to_h }

      it "contains the attribute combined from the CSV" do
        expect(to_h).to include(name: "Rick Sanchez")
      end
    end
  end
end
