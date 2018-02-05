class <%= class_name %>Importer < ApplicationImporter
<% if attributes -%>
  attributes <%= attributes.map { |attribute| ":#{attribute.name}" }.join(', ') %>
<% end -%>
end
