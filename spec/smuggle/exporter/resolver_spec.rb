# frozen_string_literal: true

require "spec_helper"

# This class quacks like an ActiveRecord::Relation
class DummyUserRelation
  def name
    "User"
  end
end

RSpec.describe Smuggle::Exporter::Resolver do
  subject(:resolver) { described_class.new }

  let(:scope) { DummyUserRelation.new }

  describe "#call" do
    subject(:call) { resolver.call(scope: scope) }

    context "when the exporter class for the given scope is defined" do
      before do
        UserExporter = Class.new(Smuggle::Exporter::Base)
      end

      after do
        Object.send(:remove_const, :UserExporter)
      end

      it { is_expected.to eq(UserExporter) }
    end

    context "when the exporter class for the given scope is not defined" do
      it "raises an exception" do
        expect { call }.to raise_error(Smuggle::ExporterNotFound)
      end
    end
  end
end
