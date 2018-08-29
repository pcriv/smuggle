module Exporters
  class WithAttributesAndLabels < Smuggle::Exporter::Base
    attributes :name
    attribute_labels name: 'Full name'
  end
end
