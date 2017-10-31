require 'test_helper'

describe SlackApiWrapper do
  it "Can get a list of channels" do
    VCR.use_cassette("channels") do
      result = SlackApiWrapper.list_channels
      # Check something
    end
  end
end
