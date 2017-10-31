require 'test_helper'

describe SlackApiWrapper do
  describe "list_channels" do
    it "Can get a list of channels" do
      VCR.use_cassette("channels") do
        result = SlackApiWrapper.list_channels
        result.must_be_kind_of Array
        result.length.must_be :>, 0
        result.each do |chan|
          chan.must_be_kind_of Channel
        end
      end
    end

    it "Raises an ApiError when the token is bad" do
      VCR.use_cassette("channels") do
        proc {
          SlackApiWrapper.list_channels("bogus_token")
        }.must_raise SlackApiWrapper::ApiError
      end
    end
  end

  describe "send_msg" do
    it "Can send a message to a channel" do
      VCR.use_cassette("channels") do
        result = SlackApiWrapper.send_msg("test-api-channel", "test message")
        result.must_equal true
      end
    end

    it "Raises an ApiError if the channel D.N.E." do
      VCR.use_cassette("channels") do
        proc {
          SlackApiWrapper.send_msg("channel-that-doesnt-exist", "test message")
        }.must_raise SlackApiWrapper::ApiError
      end
    end

    it "Does something if the message is blank" do
      VCR.use_cassette("channels") do
        proc {
          SlackApiWrapper.send_msg("test-api-channel", "")
        }.must_raise SlackApiWrapper::ApiError
      end
    end
  end
end
