class <%= scope.camelize %>Exporter < Smuggle::Base
  attributes <%= attributes.map { |attribute| ":#{attribute}" }.join(', ') %>
end
