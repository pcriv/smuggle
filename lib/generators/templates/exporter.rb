class <%= scope.camelize %>Exporter < Smuggle::Base
<% if attributes -%>
  attributes <%= attributes.map { |attribute| ":#{attribute}" }.join(', ') %>
<% end -%>
end
