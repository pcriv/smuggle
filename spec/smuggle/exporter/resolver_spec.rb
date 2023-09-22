# frozen_string_literal: true

require "spec_helper"

RSpec.describe Smuggle::Exporter::Resolver do
  subject(:resolver) { described_class.new }

  let(:scope) { DummyUserRelation.new }

  describe "#call" do
    subject(:call) { resolver.call(scope: scope) }

    context "when the exporter class for the given scope is defined" do
      it { is_expected.to eq(UserExporter) }
    end

    context "when the exporter class for the given scope is not defined" do
      let(:scope) { Object }

      it "raises an exception" do
        expect { call }.to raise_error(Smuggle::ExporterNotFound)
      end
    end
  end
end
