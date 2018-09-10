# frozen_string_literal: true

require "spec_helper"

RSpec.describe Smuggle do
  it "has a version number" do
    expect(Smuggle::VERSION).not_to be nil
  end
end
