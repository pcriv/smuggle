# frozen_string_literal: true

require "spec_helper"

RSpec.describe Smuggle::Importer::Resolver do
  subject(:resolver) { described_class.new }

  let(:model) { User }

  describe "#call" do
    subject(:call) { resolver.call(model: model) }

    context "when the importer class for the given model is defined" do
      it { is_expected.to eq(UserImporter) }
    end

    context "when the importer class for the given model is not defined" do
      let(:model) { Object }

      it "raises an exception" do
        expect { call }.to raise_error(Smuggle::ImporterNotFound)
      end
    end
  end
end
