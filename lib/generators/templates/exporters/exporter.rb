class <%= scope.camelize %>Exporter < ApplicationExporter
<% if attributes -%>
  attributes <%= attributes.map { |attribute| ":#{attribute}" }.join(', ') %>
<% end -%>
end
