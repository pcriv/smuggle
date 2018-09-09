# frozen_string_literal: true

require "spec_helper"

RSpec.describe Smuggle::Exporter::Base do
  describe "#to_csv" do
    context "when record is a plain ruby object with attributes defined" do
      let(:record) { build_record }
      let(:exporter) { Exporters::WithAttributes.new(record) }

      it "returns record converted to csv as an array" do
        expect(exporter.to_csv).to eq([record.name])
      end
    end

    context "when record is a plain ruby object without attributes defined" do
      let(:record) { build_record }
      let(:exporter) { Exporters::WithoutAttributes.new(record) }

      it "returns record converted to csv as an array" do
        expect(exporter.to_csv).to eq([record.name, record.location])
      end
    end

    context "when record is a Hash with attributes defined" do
      let(:record) { Hash(name: "Rick Sanchez", location: "Dimension C-132") }
      let(:exporter) { Exporters::WithAttributes.new(record) }

      it "returns record converted to csv as an array" do
        expect(exporter.to_csv).to eq([record[:name]])
      end
    end

    context "when record is a Hash without attributes defined" do
      let(:record) { Hash(name: "Rick Sanchez", location: "Dimension C-132") }
      let(:exporter) { Exporters::WithoutAttributes.new(record) }

      it "returns record converted to csv as an array" do
        expect(exporter.to_csv).to eq(record.values)
      end
    end
  end
end
