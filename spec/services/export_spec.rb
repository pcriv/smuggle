require 'spec_helper'

RSpec.describe Smuggle::Services::Export do
  describe '.call' do
    let(:scope) { build_list(:user, 10) }

    context 'without exporter option' do
      it 'raises exception' do
        expect { described_class.call(scope: scope) }.to raise_error(Smuggle::ExporterNotFound)
      end
    end

    context 'with exporter option' do
      let(:params) { Hash(scope: scope, exporter: Exporters::WithAttributes) }

      it 'returns csv data' do
        expect(described_class.call(params)).to match(/\A([\S ]+(\n))+\z/)
      end
    end

    context 'with attribute labels' do
      let(:params) { Hash(scope: scope, exporter: Exporters::WithAttributesAndLabels) }

      it 'returns csv data with labels in the header row' do
        expect(described_class.call(params)).to start_with("Full name")
      end
    end
  end
end
