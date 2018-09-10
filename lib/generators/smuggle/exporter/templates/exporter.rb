class <%= class_name %>Exporter < ApplicationExporter
<% if attributes -%>
  attributes <%= attributes.map { |attribute| ":#{attribute.name}" }.join(', ') %>
<% end -%>
end
