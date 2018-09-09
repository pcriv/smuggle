# frozen_string_literal: true

require "spec_helper"

RSpec.describe Smuggle::Services::Export do
  describe ".call" do
    subject(:call) { described_class.call(params) }

    let(:scope) { build_records(10) }

    context "without exporter option" do
      let(:params) { Hash(scope: scope) }

      it "raises exception" do
        expect { call }.to raise_error(Smuggle::ExporterNotFound)
      end
    end

    context "with exporter option" do
      let(:params) { Hash(scope: scope, exporter: Exporters::WithAttributes) }

      it "returns csv data" do
        expect(call).to match(/\A([\S ]+(\n))+\z/)
      end
    end

    context "with attribute labels" do
      let(:params) { Hash(scope: scope, exporter: Exporters::WithAttributesAndLabels) }

      it "returns csv data with labels in the header row" do
        expect(call).to start_with("Full name")
      end
    end
  end
end
