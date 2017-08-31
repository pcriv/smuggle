require 'spec_helper'

RSpec.describe Smuggle::Exporter::Base do
  describe '#to_csv' do
    context 'when record is a plain ruby object' do
      let(:record) { build(:user) }

      context 'with attributes defined' do
        let(:exporter) { Exporters::WithAttributes.new(record) }

        it 'returns record converted to csv as an array' do
          expect(exporter.to_csv).to eq([record.name])
        end
      end

      context 'without attributes defined' do
        let(:exporter) { Exporters::WithoutAttributes.new(record) }

        it 'returns record converted to csv as an array' do
          expect(exporter.to_csv).to eq([record.name, record.location])
        end
      end
    end

    context 'when record is a Hash' do
      let(:record) { Hash(name: 'Rick Sanchez', location: 'Dimension C-132') }

      context 'with attributes defined' do
        let(:exporter) { Exporters::WithAttributes.new(record) }

        it 'returns record converted to csv as an array' do
          expect(exporter.to_csv).to eq([record[:name]])
        end
      end

      context 'without attributes defined' do
        let(:exporter) { Exporters::WithoutAttributes.new(record) }

        it 'returns record converted to csv as an array' do
          expect(exporter.to_csv).to eq(record.values)
        end
      end
    end
  end
end
