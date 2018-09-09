# frozen_string_literal: true

require "spec_helper"

RSpec.describe Smuggle::Services::Import do
  describe ".call" do
    let(:model) { User }
    let(:filepath) { "spec/support/users.csv" }

    context "without importer option" do
      subject(:call) { described_class.call(model: model, filepath: filepath) }

      it "raises exception" do
        expect { call }.to raise_error(Smuggle::ImporterNotFound)
      end
    end

    context "with importer option" do
      subject(:call) { described_class.call(model: model, filepath: filepath, importer: importer) }

      let(:importer) { Importers::UserImporter }

      it "imports rows from csv file" do
        expect { call }.to change { importer.db.count }.from(0).to(3)
      end

      it { is_expected.to be_an Array }
    end
  end
end
