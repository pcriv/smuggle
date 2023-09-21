# frozen_string_literal: true

require "spec_helper"

UserImporter = Class.new(Smuggle::Importer::Base)

RSpec.describe Smuggle::Importer::Resolver do
  subject(:resolver) { described_class.new }

  let(:model) { User }

  describe "#call" do
    subject(:call) { resolver.call(model: model) }

    context "when the importer class for the given model is defined" do
      after do
        Object.send(:remove_const, :UserImporter)
      end

      it { is_expected.to eq(UserImporter) }
    end

    context "when the importer class for the given model is not defined" do
      it "raises an exception" do
        expect { call }.to raise_error(Smuggle::ImporterNotFound)
      end
    end
  end
end
