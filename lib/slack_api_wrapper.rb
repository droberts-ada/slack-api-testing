# require `httparty`

class SlackApiWrapper
  BASE_URL = "https://slack.com/api/"
  TOKEN = ENV["SLACK_TOKEN"]

  class ApiError < StandardError
  end

  def self.list_channels(token=TOKEN)
    url = BASE_URL + "channels.list?" + "token=#{token}" + "&pretty=1&exclude_archived=1"

    data = HTTParty.get(url)

    check_status(data)

    channel_list = []
    if data["channels"]
      data["channels"].each do |channel_data|
        channel_list << self.create_channel(channel_data)
      end
    end

    return channel_list
  end

  def self.send_msg(channel, msg)
    puts "Sending message to channel #{channel}: #{msg}"

    url = BASE_URL + "chat.postMessage?" + "token=#{TOKEN}"

    response = HTTParty.post(url,
    body:  {
      "text" => "#{msg}",
      "channel" => "#{channel}",
      "username" => "Roberts-Robit",
      "icon_emoji" => ":robot_face:",
      "as_user" => "false"
    },
    :headers => { 'Content-Type' => 'application/x-www-form-urlencoded' })

    check_status(response)

    return true
  end

  private

  def self.check_status(response)
    unless response["ok"]
      raise ApiError.new("API call to slack failed: #{response["error"]}")
    end
  end

  def self.create_channel(api_params)
    return Channel.new(
      api_params["name"],
      api_params["id"],
      {
        purpose: api_params["purpose"],
        is_archived: api_params["is_archived"],
        members: api_params["members"]
      }
    )
  end
end
