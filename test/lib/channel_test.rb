require 'test_helper'

describe Channel do

  it "Can be instantiated with a name and ID" do
    Channel.new("name", "id")
  end

  it "Requires a name and ID" do
    proc {
      Channel.new()
    }.must_raise ArgumentError

    proc {
      Channel.new("name")
    }.must_raise ArgumentError

    # Empty strings are not permitted either
    proc {
      Channel.new("", "")
    }.must_raise ArgumentError
  end

  it "Tracks name and ID" do
    name = "test_name"
    id = "test_id"
    chan = Channel.new(name, id)
    chan.name.must_equal name
    chan.id.must_equal id
  end

  it "Tracks optional args" do
    options = {
      purpose: "test_purpose",
      is_archived: "test_archived",
      is_general: "test_general",
      members: "test_members"
    }
    chan = Channel.new("name", "id", options)
    
    chan.purpose.must_equal options[:purpose]
    chan.is_archived.must_equal options[:is_archived]
    chan.is_general.must_equal options[:is_general]
    chan.members.must_equal options[:members]
  end


end
