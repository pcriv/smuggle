require 'spec_helper'

RSpec.describe Smuggle::Services::Import do
  describe '.call' do
    let(:model) { User }
    let(:filepath) { 'spec/support/users.csv' }

    context 'without importer option' do
      it 'raises exception' do
        expect { described_class.call(model: model, filepath: filepath) }.to raise_error(Smuggle::ImporterNotFound)
      end
    end

    context 'with importer option' do
      let(:importer) { Importers::UserImporter }

      before { described_class.call(model: model, filepath: filepath, importer: importer) }

      it 'imports rows from csv file' do
        expect(importer.db.count).to eq 3
      end
    end
  end
end
