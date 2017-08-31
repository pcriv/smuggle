require 'smuggle/version'
require 'smuggle/base'
require 'smuggle/exporter'
require 'smuggle/exporter_not_found'

module Smuggle
  require 'smuggle/engine' if defined?(Rails)
  # Your code goes here...
end
