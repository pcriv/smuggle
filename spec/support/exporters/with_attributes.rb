# frozen_string_literal: true

module Exporters
  class WithAttributes < Smuggle::Exporter::Base
    attributes :name
  end
end
